locals {
  core_addons = {
    vpc-cni = {
      before_compute = true
    }
    kube-proxy = {
      before_compute = false
    }
    coredns = {
      before_compute = false
    }
    eks-pod-identity-agent = {
      before_compute = false
    }
  }

  enabled_addons = var.enable_ebs_csi_driver ? merge(local.core_addons, {
    aws-ebs-csi-driver = {
      before_compute = false
    }
  }) : local.core_addons
}

resource "aws_eks_addon" "before_compute" {
  for_each = {
    for name, addon in local.enabled_addons : name => addon
    if addon.before_compute
  }

  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags                        = var.tags
}

resource "aws_eks_addon" "after_compute" {
  for_each = {
    for name, addon in local.enabled_addons : name => addon
    if !addon.before_compute
  }

  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags                        = var.tags

  depends_on = [
    aws_eks_node_group.default,
    aws_eks_addon.before_compute,
  ]
}


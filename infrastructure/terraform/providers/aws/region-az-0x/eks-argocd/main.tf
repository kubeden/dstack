data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket       = local.state_bucket_name
    key          = local.eks_state_key
    region       = local.region
    encrypt      = true
    use_lockfile = true
  }
}

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.aws_eks_cluster.this.name
}

resource "helm_release" "argocd" {
  name             = local.argocd_release_name
  repository       = local.argocd_helm_chart.repo
  chart            = local.argocd_helm_chart.name
  version          = local.argocd_helm_chart.version
  namespace        = local.argocd_namespace
  create_namespace = true

  values = [
    local.argocd_values_content,
  ]

  atomic  = true
  wait    = true
  timeout = 600
}


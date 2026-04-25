resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-default"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = local.cluster_subnet_ids

  ami_type       = var.node_ami_type
  capacity_type  = var.node_capacity_type
  disk_size      = var.node_disk_size
  instance_types = var.node_instance_types

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = var.node_labels
  tags   = var.tags

  lifecycle {
    precondition {
      condition     = var.node_subnet_type == "public" || var.create_private_subnets
      error_message = "create_private_subnets must be true when node_subnet_type is private."
    }

    precondition {
      condition     = var.node_subnet_type == "public" || var.enable_nat_gateway
      error_message = "enable_nat_gateway must be true for private nodes unless you add VPC endpoints separately."
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_cni,
    aws_iam_role_policy_attachment.node_ecr,
  ]
}

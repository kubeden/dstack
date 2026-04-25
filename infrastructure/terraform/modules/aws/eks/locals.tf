locals {
  cluster_subnet_ids = var.node_subnet_type == "private" ? aws_subnet.private[*].id : aws_subnet.public[*].id

  common_tags = merge(var.tags, {
    "Name"                                      = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  })
}


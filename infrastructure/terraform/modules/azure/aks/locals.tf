locals {
  common_tags = merge(var.tags, {
    "Name" = var.cluster_name
  })
}


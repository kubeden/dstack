module "eks" {
  source = "../../../../modules/aws/eks"

  cluster_name        = local.cluster_name
  vpc_cidr            = local.vpc_cidr
  public_access_cidrs = local.admin_cidrs

  create_private_subnets = local.create_private_subnets
  enable_nat_gateway     = local.enable_nat_gateway
  node_subnet_type       = local.node_subnet_type

  node_instance_types = local.node_instance_types
  node_capacity_type  = local.node_capacity_type
  node_min_size       = local.node_min_size
  node_desired_size   = local.node_desired_size
  node_max_size       = local.node_max_size

  node_labels = {
    "kubeden.io/node-pool" = "default"
  }

  tags = local.tags
}


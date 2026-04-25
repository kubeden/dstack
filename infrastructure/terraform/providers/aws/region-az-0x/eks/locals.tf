locals {
  region          = "us-east-1"
  region_code     = "use1"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix  = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"
  cluster_name = "${local.name_prefix}-eks"

  vpc_cidr = "10.60.0.0/16"

  # Cost-conscious example: public worker nodes, no NAT gateway, one spot node.
  create_private_subnets = false
  enable_nat_gateway     = false
  node_subnet_type       = "public"

  admin_cidrs = [
    "0.0.0.0/0",
  ]

  node_instance_types = ["t3.medium"]
  node_capacity_type  = "SPOT"
  node_min_size       = 1
  node_desired_size   = 1
  node_max_size       = 1

  tags = {
    Environment = local.environment
    Iteration   = local.iteration
    Customer    = local.customer_prefix
    RegionCode  = local.region_code
    ManagedBy   = "terraform"
  }
}


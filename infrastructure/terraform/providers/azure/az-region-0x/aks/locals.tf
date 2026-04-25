locals {
  location        = "westeurope"
  region_code     = "weu"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix  = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"
  compact_name = replace(local.name_prefix, "-", "")

  resource_group_name = "${local.name_prefix}-aks-rg"
  cluster_name        = "${local.name_prefix}-aks"
  dns_prefix          = "${local.compact_name}aks"

  vnet_cidr        = "10.80.0.0/16"
  node_subnet_cidr = "10.80.1.0/24"

  # Cost-conscious example: one small fixed-size node pool.
  default_node_pool_vm_size              = "Standard_B2s"
  default_node_pool_node_count           = 1
  default_node_pool_auto_scaling_enabled = false

  tags = {
    Environment = local.environment
    Iteration   = local.iteration
    Customer    = local.customer_prefix
    RegionCode  = local.region_code
    ManagedBy   = "terraform"
  }
}


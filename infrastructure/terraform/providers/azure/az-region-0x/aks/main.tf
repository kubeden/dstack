module "aks" {
  source = "../../../../modules/azure/aks"

  cluster_name        = local.cluster_name
  resource_group_name = local.resource_group_name
  location            = local.location
  dns_prefix          = local.dns_prefix

  vnet_cidr        = local.vnet_cidr
  node_subnet_cidr = local.node_subnet_cidr

  default_node_pool_vm_size              = local.default_node_pool_vm_size
  default_node_pool_node_count           = local.default_node_pool_node_count
  default_node_pool_auto_scaling_enabled = local.default_node_pool_auto_scaling_enabled

  tags = local.tags
}


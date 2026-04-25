resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool {
    name                        = var.default_node_pool_name
    vm_size                     = var.default_node_pool_vm_size
    vnet_subnet_id              = azurerm_subnet.nodes.id
    auto_scaling_enabled        = var.default_node_pool_auto_scaling_enabled
    node_count                  = var.default_node_pool_auto_scaling_enabled ? null : var.default_node_pool_node_count
    min_count                   = var.default_node_pool_auto_scaling_enabled ? var.default_node_pool_min_count : null
    max_count                   = var.default_node_pool_auto_scaling_enabled ? var.default_node_pool_max_count : null
    os_disk_size_gb             = var.default_node_pool_os_disk_size_gb
    temporary_name_for_rotation = "tmpnodes"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = "standard"
    outbound_type     = var.outbound_type
  }

  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  tags = local.common_tags
}


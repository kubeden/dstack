data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "common" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.common.name
  location                        = azurerm_resource_group.common.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true

  blob_properties {
    versioning_enabled = true
  }

  tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = local.storage_container
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

resource "azurerm_key_vault" "common" {
  name                        = local.key_vault_name
  location                    = azurerm_resource_group.common.location
  resource_group_name         = azurerm_resource_group.common.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enabled_for_disk_encryption = true

  tags = local.tags
}


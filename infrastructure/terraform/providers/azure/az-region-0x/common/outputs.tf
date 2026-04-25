output "resource_group_name" {
  description = "Common Azure resource group name."
  value       = azurerm_resource_group.common.name
}

output "storage_account_name" {
  description = "Terraform state storage account name."
  value       = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
  description = "Terraform state storage container name."
  value       = azurerm_storage_container.tfstate.name
}

output "key_vault_name" {
  description = "Common Key Vault name."
  value       = azurerm_key_vault.common.name
}


output "primary_resource_group_name" {
  description = "Name of the resource group in the primary region"
  value       = azurerm_resource_group.primary.name
}

output "secondary_resource_group_name" {
  description = "Name of the resource group in the secondary region"
  value       = azurerm_resource_group.secondary.name
}

output "primary_storage_account_name" {
  description = "Name of the storage account in the primary region"
  value       = azurerm_storage_account.primary.name
}

output "secondary_storage_account_name" {
  description = "Name of the storage account in the secondary region"
  value       = azurerm_storage_account.secondary.name
}
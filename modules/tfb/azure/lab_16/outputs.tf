output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.example.name
}

output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.example.name
}

output "container_name" {
  description = "Name of the created storage container"
  value       = azurerm_storage_container.example.name
}

output "user_assigned_identity_id" {
  description = "ID of the created user-assigned managed identity"
  value       = azurerm_user_assigned_identity.example.id
}

output "policy_definition_id" {
  description = "ID of the created policy definition"
  value       = azurerm_policy_definition.example.id
}
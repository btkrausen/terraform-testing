output "subscription_id" {
  description = "The Azure Subscription ID"
  value       = data.azurerm_subscription.current.subscription_id
  sensitive   = true
}

output "tenant_id" {
  description = "The Azure Tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
  sensitive   = true
}

output "location_info" {
  description = "Information about the current location"
  value       = data.azurerm_location.current.display_name
}

output "resource_group_id" {
  description = "ID of the development resource group"
  value       = azurerm_resource_group.development.id
}
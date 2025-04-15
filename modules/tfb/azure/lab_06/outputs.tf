output "resource_group_id" {
  description = "ID of the created Resource Group"
  value       = azurerm_resource_group.production.id
}

output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.production.id
}

output "subscription_info" {
  description = "Azure Subscription Information"
  value       = "${data.azurerm_subscription.current.display_name} (${data.azurerm_subscription.current.subscription_id})"
}

output "tenant_id" {
  description = "Azure Tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
  sensitive   = true
}
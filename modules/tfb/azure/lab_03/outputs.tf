output "resource_group_id" {
  description = "ID of the created Resource Group"
  value       = azurerm_resource_group.main.id
}

output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = azurerm_virtual_network.main.address_space
}
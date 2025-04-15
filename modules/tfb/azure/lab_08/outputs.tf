output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "vnet_ids" {
  description = "The IDs of the virtual networks"
  value       = azurerm_virtual_network.vnet[*].id
}

output "vnet_address_spaces" {
  description = "The address spaces of the virtual networks"
  value       = azurerm_virtual_network.vnet[*].address_space
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = azurerm_subnet.subnet[*].id
}

output "nsg_ids" {
  description = "The IDs of the network security groups"
  value       = azurerm_network_security_group.nsg[*].id
}
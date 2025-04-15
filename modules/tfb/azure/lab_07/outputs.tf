output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "web_subnet_id" {
  description = "The ID of the web subnet"
  value       = azurerm_subnet.web.id
}

output "app_subnet_id" {
  description = "The ID of the app subnet"
  value       = azurerm_subnet.app.id
}

output "db_subnet_id" {
  description = "The ID of the database subnet"
  value       = azurerm_subnet.db.id
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.web.id
}
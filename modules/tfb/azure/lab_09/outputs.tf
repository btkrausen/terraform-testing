output "vnet_count_ids" {
  description = "The IDs of the count-based virtual networks"
  value       = azurerm_virtual_network.vnet_count
}

output "vnet_foreach_ids" {
  description = "The IDs of the for_each-based virtual networks"
  value       = azurerm_virtual_network.vnet_foreach
}

output "subnet_foreach_ids" {
  description = "The IDs of the for_each-based subnets"
  value       = azurerm_subnet.subnet_foreach
}

output "nsg_foreach_ids" {
  description = "The IDs of the for_each-based NSGs"
  value       = azurerm_network_security_group.nsg_foreach
}

output "route_table_ids" {
  description = "The IDs of the for_each-based route tables"
  value       = azurerm_route_table.rt_foreach
}
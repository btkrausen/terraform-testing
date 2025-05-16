output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.main.id
}

output "vnet_count" {
  description = "Number of virtual networks created (using min function)"
  value       = min(length(var.locations), length(var.address_spaces))
}

output "unique_teams" {
  description = "List of unique teams (using toset function)"
  value       = local.unique_teams
}
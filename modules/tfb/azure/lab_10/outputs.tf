output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.example.name
}

output "virtual_network_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.example.id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.example.name
}

output "storage_containers" {
  description = "Names of the Storage Containers"
  value = [
    azurerm_storage_container.logs.name,
    azurerm_storage_container.data.name,
    azurerm_storage_container.backups.name
  ]
}

output "dependency_example" {
  description = "Example of dependencies in this lab"
  value = {
    "Implicit dependencies" = "Resource Group -> VNet -> Subnet, Resource Group -> NSG, Resource Group -> Storage Account"
    "Explicit dependencies" = "Logs/Data containers -> Backup container, NSG Association -> NSG Rule"
  }
}
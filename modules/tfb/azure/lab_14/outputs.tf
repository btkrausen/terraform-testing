output "vnet_id" {
  description = "The ID of the basic Virtual Network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the basic Virtual Network"
  value       = module.vnet.vnet_name
}

output "avm_vnet_id" {
  description = "The ID of the AVM Virtual Network"
  value       = module.avm_vnet.resource.id
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.example.id
}
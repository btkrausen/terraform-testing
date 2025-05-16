output "role_definition_id" {
  description = "ID of the role definition"
  value       = azurerm_role_definition.this.role_definition_id
}

output "role_definition_name" {
  description = "Name of the role definition"
  value       = azurerm_role_definition.this.name
}

output "role_definition_scope" {
  description = "Scope of the role definition"
  value       = azurerm_role_definition.this.scope
}
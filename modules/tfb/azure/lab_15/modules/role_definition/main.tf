resource "azurerm_role_definition" "this" {
  name        = "${var.environment}-${var.role_name}"
  scope       = var.scope
  description = var.description != "" ? var.description : "Custom role for ${var.role_name}"

  permissions {
    actions          = var.permissions.actions
    data_actions     = var.permissions.data_actions
    not_actions      = var.permissions.not_actions
    not_data_actions = var.permissions.not_data_actions
  }

  assignable_scopes = [
    var.scope
  ]
}
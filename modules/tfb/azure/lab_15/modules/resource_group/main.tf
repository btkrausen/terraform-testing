resource "azurerm_resource_group" "this" {
  name     = "${var.environment}-${var.name_prefix}-rg"
  location = var.location

  tags = merge({
    Environment = var.environment
    ManagedBy   = "Terraform"
  }, var.tags)
}
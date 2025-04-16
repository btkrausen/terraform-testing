# Resource Group in primary region
resource "azurerm_resource_group" "primary" {
  provider = azurerm.primary
  name     = "rg-${var.environment}-primary"
  location = var.primary_location

  tags = {
    Environment = var.environment
    Region      = var.primary_location
  }
}

# Resource Group in secondary region
resource "azurerm_resource_group" "secondary" {
  provider = azurerm.secondary
  name     = "rg-${var.environment}-secondary"
  location = var.secondary_location

  tags = {
    Environment = var.environment
    Region      = var.secondary_location
  }
}

# Storage Account in primary region
resource "azurerm_storage_account" "primary" {
  provider                 = azurerm.primary
  name                     = "sa${var.environment}${formatdate("YYMMDD", timestamp())}"
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    Region      = var.primary_location
  }
}

# Storage Account in secondary region
resource "azurerm_storage_account" "secondary" {
  provider                 = azurerm.secondary
  name                     = "sa${var.environment}sec${formatdate("YYMMDD", timestamp())}"
  resource_group_name      = azurerm_resource_group.secondary.name
  location                 = azurerm_resource_group.secondary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    Region      = var.secondary_location
  }
}

# Storage Container in primary region
resource "azurerm_storage_container" "primary" {
  provider              = azurerm.primary
  name                  = "data"
  storage_account_id    = azurerm_storage_account.primary.id
  container_access_type = "private"
}

# Storage Container in secondary region
resource "azurerm_storage_container" "secondary" {
  provider              = azurerm.secondary
  name                  = "data"
  storage_account_id    = azurerm_storage_account.secondary.id
  container_access_type = "private"
}
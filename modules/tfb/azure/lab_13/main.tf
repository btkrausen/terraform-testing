# Random string to ensure uniqueness
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Use join function to create a resource group name
resource "azurerm_resource_group" "main" {
  name     = join("-", [var.environment, "rg", random_string.suffix.result])
  location = var.location

  tags = {
    Environment = var.environment
    Purpose     = "Terraform Function Lab"
  }
}

# Use min function to determine how many virtual networks to create
# This ensures we don't try to create more networks than we have address spaces
resource "azurerm_virtual_network" "main" {
  count               = min(length(var.locations), length(var.address_spaces))
  name                = "${var.environment}-vnet-${count.index + 1}"
  location            = var.locations[count.index]
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.address_spaces[count.index]]

  tags = {
    Name = "${var.environment}-vnet-${count.index + 1}"
  }
}

# Use toset function to remove duplicates from teams list
locals {
  unique_teams = toset(var.teams)
}

# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "${var.environment}-nsg-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Name  = "${var.environment}-nsg"
    Teams = join(", ", local.unique_teams)
    # This joins unique team names with commas
  }
}
# Create the resource group
resource "azurerm_resource_group" "main" {
  name     = "terraform-course"
  location = var.location

  tags = {
    Name        = "terraform-course"
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}

# Create the virtual network
resource "azurerm_virtual_network" "main" {
  name                = "terraform-network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space

  tags = {
    Name        = "terraform-course"
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}

# Add resources for the lab below

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.environment}-modules"
  location = var.location

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Use the Virtual Network module from Terraform Registry
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "5.0.1"

  resource_group_name = azurerm_resource_group.example.name
  vnet_location       = var.location

  # Basic network configuration
  vnet_name     = "vnet-${var.environment}"
  address_space = ["10.0.0.0/16"]

  # Empty subnet lists - we'll create subnets using a different module with for_each
  subnet_names    = []
  subnet_prefixes = []

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# Random string for uniqueness
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

# Using a module with for_each to create multiple subnets
module "avm_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  # Basic VNet configuration
  enable_telemetry    = false
  name                = "vnet-main-${random_string.suffix.result}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  # Here's the for_each on subnets
  subnets = {
    for name, prefix in var.subnets : name => {
      name             = "snet-${name}"
      address_prefixes = [prefix]
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    ModuleDemo  = "true"
  }
}
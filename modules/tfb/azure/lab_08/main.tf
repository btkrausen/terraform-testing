# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "main-resources"
  location = "eastus"

  tags = {
    Environment = "Development"
  }
}

# Refactored Virtual Networks using count
resource "azurerm_virtual_network" "vnet" {
  count               = var.vnet_count                         # <-- add count meta-argument here
  name                = "vnet-${count.index + 1}"              # <-- use count.index for dynamic names
  address_space       = [var.vnet_address_spaces[count.index]] # <-- use count.index for dynamic address space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    Network     = "VNet${count.index + 1}" # <-- use count.index for tag
  }
}

# Refactored Subnets using count
resource "azurerm_subnet" "subnet" {
  count                = var.subnet_count
  name                 = "subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
}

# Refactored Network Security Groups using count
resource "azurerm_network_security_group" "nsg" {
  count               = 3 # Creating 3 NSGs
  name                = "${var.nsg_configs[count.index].name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = var.nsg_configs[count.index].rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = tostring(var.nsg_configs[count.index].port)
    source_address_prefix      = var.nsg_configs[count.index].source_addrs
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "Development"
    Role        = var.nsg_configs[count.index].name
  }
}
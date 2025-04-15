# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "primary-resources"
  location = "eastus"

  tags = {
    Environment = "Development"
  }
}

# Virtual Networks created with count
resource "azurerm_virtual_network" "vnet_count" {
  count               = 3
  name                = "vnet-count-${count.index + 1}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    Network     = "Network-${count.index + 1}"
  }
}

# Subnets created with count
resource "azurerm_subnet" "subnet_count" {
  count                = 3
  name                 = "subnet-count-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet_count[0].name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

# Network Security Groups created with count
resource "azurerm_network_security_group" "nsg_count" {
  count               = 3
  name                = "nsg-count-${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "rule-${count.index + 1}"
    priority                   = 100 + count.index
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = tostring(80 + count.index * 1000)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "Development"
    Type        = "NSG-${count.index + 1}"
  }
}

# Virtual Networks created with for_each
resource "azurerm_virtual_network" "vnet_foreach" {
  for_each            = var.vnet_config
  name                = "vnet-${each.key}"
  address_space       = [each.value]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    Network     = "Network-${each.key}"
  }
}

# Subnets created with for_each
resource "azurerm_subnet" "subnet_foreach" {
  for_each             = var.subnet_config
  name                 = "subnet-${each.key}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet_foreach["production"].name
  address_prefixes     = [each.value]
}

# Network Security Groups created with for_each
resource "azurerm_network_security_group" "nsg_foreach" {
  for_each            = var.nsg_ports_map
  name                = "nsg-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-${each.key}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = each.value
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "Development"
    Service     = each.key
  }
}

# Route tables created with for_each
resource "azurerm_route_table" "rt_foreach" {
  for_each            = var.route_tables
  name                = "rt-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    Description = each.value
  }
}
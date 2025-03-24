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

# Create Subnets
resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.web_subnet_cidr]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.app_subnet_cidr]
}

# Network Security Groups
resource "azurerm_network_security_group" "web" {
  name                = "web-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Name        = "web-nsg"
    Environment = var.environment
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "app-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Name        = "app-nsg"
    Environment = var.environment
  }
}

# NSG Rules for Web Subnet
resource "azurerm_network_security_rule" "web_http" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_network_security_rule" "web_https" {
  name                        = "Allow-HTTPS"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.web.name
}

# NSG Rule for App Subnet
resource "azurerm_network_security_rule" "app_internal" {
  name                        = "Allow-Internal"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "8080"
  source_address_prefix      = var.web_subnet_cidr
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.app.name
}

# NSG Associations
resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}
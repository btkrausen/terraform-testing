# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "depends-on-${var.environment}-rg"
  location = var.location

  tags = {
    Environment = var.environment
  }
}

# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "${var.environment}-vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    Environment = var.environment
  }
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefix
}

# Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "${var.environment}-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment
  }
}

# Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "sa${var.environment}${formatdate("YYMMDD", timestamp())}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
  }
}

# Subnet NSG Association
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

# Storage Containers
resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
}

# Storage container with explicit dependency
resource "azurerm_storage_container" "backups" {
  name                  = "backups"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"

  # Explicitly depend on the other containers - this ensures the other containers are created first
  depends_on = [
    azurerm_storage_container.logs,
    azurerm_storage_container.data
  ]
}

# Network Security Group Rule with explicit dependency
resource "azurerm_network_security_rule" "https" {
  name                        = "AllowHTTPS"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name

  # Explicitly depend on the NSG association to ensure the NSG is attached to the subnet before adding rules
  depends_on = [azurerm_subnet_network_security_group_association.example]
}
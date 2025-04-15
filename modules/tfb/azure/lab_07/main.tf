# Get subscription information
data "azurerm_subscription" "current" {}

locals {
  # Common tags for all resources
  tags = {
    Environment  = var.environment
    Project      = "terraform-improved-demo"
    Owner        = "devops-team"
    CostCenter   = "cc-5678"
    Region       = var.location
    ManagedBy    = "terraform"
    Subscription = data.azurerm_subscription.current.display_name
  }

  # Common name prefix for resources
  name_prefix = "${var.environment}-tf-"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}resources"
  location = var.location

  tags = {
    Name         = "${local.name_prefix}resources"
    Environment  = local.tags.Environment
    Project      = local.tags.Project
    Owner        = local.tags.Owner
    CostCenter   = local.tags.CostCenter
    Region       = local.tags.Region
    ManagedBy    = local.tags.ManagedBy
    Subscription = local.tags.Subscription
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${local.name_prefix}vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space

  tags = {
    Name         = "${local.name_prefix}vnet"
    Environment  = local.tags.Environment
    Project      = local.tags.Project
    Owner        = local.tags.Owner
    CostCenter   = local.tags.CostCenter
    Region       = local.tags.Region
    ManagedBy    = local.tags.ManagedBy
    Subscription = local.tags.Subscription
  }
}

resource "azurerm_subnet" "web" {
  name                 = "${local.name_prefix}web-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "app" {
  name                 = "${local.name_prefix}app-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "${local.name_prefix}db-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "web" {
  name                = "${local.name_prefix}web-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name         = "${local.name_prefix}web-nsg"
    Environment  = local.tags.Environment
    Project      = local.tags.Project
    Owner        = local.tags.Owner
    CostCenter   = local.tags.CostCenter
    Region       = local.tags.Region
    ManagedBy    = local.tags.ManagedBy
    Subscription = local.tags.Subscription
  }
}
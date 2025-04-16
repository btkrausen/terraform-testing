terraform {
  required_version = ">= 1.10.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Primary region provider
provider "azurerm" {
  features {}
  alias = "primary"
}

# Secondary region provider
provider "azurerm" {
  features {}
  alias = "secondary"
}
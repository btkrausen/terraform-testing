variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type        = list(string)
  default     = ["192.168.0.0/16"]
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "learning-terraform"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

# Subnet Variables
variable "web_subnet_cidr" {
  description = "CIDR block for web subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet_cidr" {
  description = "CIDR block for app subnet"
  type        = string
  default     = "10.0.2.0/24"
}
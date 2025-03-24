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
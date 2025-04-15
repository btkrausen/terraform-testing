variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name for resource naming and tagging"
  type        = string
  default     = "production"
}

variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
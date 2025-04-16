variable "primary_location" {
  description = "Primary Azure location"
  type        = string
  default     = "eastus"
}

variable "secondary_location" {
  description = "Secondary Azure location"
  type        = string
  default     = "westus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
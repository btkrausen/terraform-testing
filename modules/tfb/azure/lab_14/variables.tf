variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "East US"
}

# Simple map of subnet configurations
variable "subnets" {
  description = "Map of subnet names to address prefixes"
  type        = map(string)
  default = {
    "web"  = "10.0.1.0/24"
    "app"  = "10.0.2.0/24"
    "data" = "10.0.3.0/24"
    "mgmt" = "10.0.4.0/24"
  }
}
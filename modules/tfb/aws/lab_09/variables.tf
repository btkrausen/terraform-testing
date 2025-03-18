variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "security_groups" {
  description = "Security group names"
  type        = list(string)
  default     = ["web", "app", "db"]
}

variable "sg_ports" {
  description = "Ports for security group rules"
  type        = list(number)
  default     = [80, 8080, 3306]
}

# New map variables for for_each
variable "subnet_config" {
  description = "Map of subnet configurations"
  type        = map(string)
  default = {
    "public"   = "10.0.10.0/24"
    "private1" = "10.0.20.0/24"
  }
}

variable "subnet_azs" {
  description = "Map of subnet availability zones"
  type        = map(string)
  default = {
    "public"   = "us-east-1a"
    "private1" = "us-east-1b"
  }
}

variable "security_group_config" {
  description = "Map of security group ports"
  type        = map(number)
  default = {
    "web"   = 80
    "app"   = 8080
    "db"    = 3306
    "cache" = 6379
  }
}

variable "route_tables" {
  description = "Map of route tables to create"
  type        = map(string)
  default = {
    "public"   = "Public route table"
    "private1" = "Private route table 1"
    "private2" = "Private route table 2"
  }
}
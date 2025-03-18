variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "security_groups" {
  description = "Security group configurations"
  type = list(object({
    name         = string
    description  = string
    ingress_port = number
  }))
  default = [
    {
      name         = "web"
      description  = "Allow web traffic"
      ingress_port = 80
    },
    {
      name         = "app"
      description  = "Allow application traffic"
      ingress_port = 8080
    },
    {
      name         = "db"
      description  = "Allow database traffic"
      ingress_port = 3306
    }
  ]
}

variable "route_table_count" {
  description = "Number of route tables to create"
  type        = number
  default     = 2
}
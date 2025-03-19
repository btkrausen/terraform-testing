variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "main-vpc"
}

variable "s3_buckets" {
  description = "Map of S3 buckets to create"
  type        = map(string)
  default = {
    "logs"      = "Stores application logs"
    "artifacts" = "Stores build artifacts"
    "configs"   = "Stores application configs"
  }
}
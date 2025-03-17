# Get information about available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Get the current region
data "aws_region" "current" {}

# Get the current caller identity
data "aws_caller_identity" "current" {}

# Create a VPC using data source information
resource "aws_vpc" "development" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "development-vpc"
    Environment = "development"
    Region      = data.aws_region.current.name
    Account     = data.aws_caller_identity.current.account_id
    CreatedBy   = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  }
}

# Create a subnet using AZ information
resource "aws_subnet" "development" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "development-subnet"
    Environment = "development"
    AZInfo      = "${data.aws_region.current.name}-${data.aws_availability_zones.available.names[0]}"
  }
}
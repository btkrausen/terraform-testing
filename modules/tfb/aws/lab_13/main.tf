# Add resource blocks below

# Use join function to create a VPC name
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = join("-", [var.environment, "vpc"])
    # This creates "dev-vpc" using the join function
  }
}

# Use min function to determine how many subnets to create
# This ensures we don't try to create more subnets than we have AZs
resource "aws_subnet" "main" {
  count             = min(length(var.availability_zones), length(var.subnet_cidrs))
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.environment}-subnet-${count.index + 1}"
  }
}

# Use toset function to remove duplicates from teams list
locals {
  unique_teams = toset(var.teams)
}

# Create security group 
resource "aws_security_group" "example" {
  name        = "${var.environment}-security-group"
  description = "Example security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name  = "${var.environment}-security-group"
    Teams = join(", ", local.unique_teams)
    # This joins unique team names with commas and a space between each value
  }
}
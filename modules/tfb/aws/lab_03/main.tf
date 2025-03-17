# Create the primary VPC for workloads
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dn   = true

  tags = {
    Name        = "terraform-course"
    Environment = var.environment
  }
}
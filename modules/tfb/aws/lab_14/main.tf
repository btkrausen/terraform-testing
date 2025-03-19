# Add resource blocks below

# Random string for uniqueness
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.environment}-${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# Module 2: Security Group Module from Terraform Registry
# This module uses the VPC ID output from the VPC module
module "security_group_web" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.environment}-web-sg"
  description = "Security group for web servers"
  vpc_id      = module.vpc.vpc_id # Using output from the VPC module

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Role        = "web"
  }
}

# Call the Security Group module a second time to create a different security group
module "security_group_app" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = module.vpc.vpc_id # Using output from the VPC module

  ingress_cidr_blocks = [var.vpc_cidr] # Only allow traffic from within the VPC
  ingress_rules       = ["ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Application port"
      cidr_blocks = var.vpc_cidr
    }
  ]
  egress_rules = ["all-all"]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Role        = "app"
  }
}

# Module 3: Using S3 bucket module with for_each
module "s3_buckets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.6.0"

  for_each = var.s3_buckets

  bucket = "${var.environment}-${each.key}-bucket-${random_string.suffix.result}"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = false
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Purpose     = each.value
    Name        = "${var.environment}-${each.key}-bucket"
  }
}
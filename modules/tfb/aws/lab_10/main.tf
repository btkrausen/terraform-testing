data "aws_caller_identity" "current" {}

# Random string for uniqueness
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "main-vpc"
    Environment = var.environment
  }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name        = "public-subnet"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "main-igw"
    Environment = var.environment
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-route-table"
    Environment = var.environment
  }
}

# S3 Bucket
resource "aws_s3_bucket" "logs" {
  bucket = "logs-${random_string.suffix.result}"

  tags = {
    Name        = "logs-bucket"
    Environment = var.environment
  }
}

# Route Table Association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "web-sg"
    Environment = var.environment
  }
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "logs_policy" {
  bucket = aws_s3_bucket.logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ]
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.logs.arn,
          "${aws_s3_bucket.logs.arn}/*"
        ]
        Principal = {
          AWS = "${data.aws_caller_identity.current.arn}"
        }
      }
    ]
  })
}

# Security Group Rule with explicit dependency
resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id

  # Explicitly depend on the route table association to ensure
  # network routing is set up before allowing traffic
  depends_on = [aws_route_table_association.public]
}

# S3 Bucket Versioning with explicit dependency
resource "aws_s3_bucket_versioning" "logs_versioning" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }

  # Explicitly depend on the bucket policy
  # This ensures the policy is fully applied before enabling versioning
  depends_on = [aws_s3_bucket_policy.logs_policy]
}

# S3 Bucket Logging configuration
resource "aws_s3_bucket_logging" "logs_logging" {
  bucket = aws_s3_bucket.logs.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "log/"

  # Explicitly depend on bucket versioning
  # This creates a chain of dependencies: policy -> versioning -> logging
  depends_on = [aws_s3_bucket_versioning.logs_versioning]
}
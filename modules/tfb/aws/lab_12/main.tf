# Random string for uniqueness
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 Bucket without lifecycle configuration
resource "aws_s3_bucket" "standard" {
  bucket = "standard-${var.environment}-${random_string.suffix.result}"

  tags = {
    Name        = "Standard Bucket"
    Environment = var.environment
  }
}

# DynamoDB Table without lifecycle configuration
resource "aws_dynamodb_table" "standard" {
  name         = "standard-${var.environment}-${random_string.suffix.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = {
    Name        = "Standard Table"
    Environment = var.environment
  }
}

# S3 Bucket with prevent_destroy
resource "aws_s3_bucket" "protected" {
  bucket = "protected-${var.environment}-${random_string.suffix.result}"

  tags = {
    Name        = "Protected Bucket"
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

# DynamoDB Table with create_before_destroy
resource "aws_dynamodb_table" "replacement" {
  name         = "replacement-${var.environment}-${random_string.suffix.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = {
    Name        = "Replacement Table"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

# SNS Topic with ignore_changes
resource "aws_sns_topic" "updates" {
  name = "updates-${var.environment}-${random_string.suffix.result}"

  tags = {
    Name        = "Updates Topic"
    Environment = var.environment
    Version     = "2.0.0" # This will be ignored
  }

  lifecycle {
    ignore_changes = [
      tags["Version"]
    ]
  }
}
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for logs"
  value       = aws_s3_bucket.logs.bucket
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web.id
}

output "dependency_example" {
  description = "Example of dependencies in this lab"
  value = {
    "Implicit dependencies" = "VPC -> Subnet, VPC -> IGW, IGW -> Route Table"
    "Explicit dependencies" = "Route Table Association -> SG Rule, Bucket Policy -> Versioning -> Logging Bucket"
  }
}
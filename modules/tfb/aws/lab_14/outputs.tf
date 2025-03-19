output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "web_security_group_id" {
  description = "The ID of the web security group"
  value       = module.security_group_web.security_group_id
}

output "app_security_group_id" {
  description = "The ID of the app security group"
  value       = module.security_group_app.security_group_id
}

output "s3_bucket_names" {
  description = "The names of the created S3 buckets"
  value       = { for k, v in module.s3_buckets : k => v.s3_bucket_id }
}
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_count" {
  description = "Number of subnets created (using min function)"
  value       = min(length(var.availability_zones), length(var.subnet_cidrs))
}

output "unique_teams" {
  description = "List of unique teams (using toset function)"
  value       = local.unique_teams
}

output "security_group_name" {
  description = "Security group name (created with join function)"
  value       = aws_security_group.example.name
}
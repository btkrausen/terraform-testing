output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.subnet[*].id
}

output "subnet_cidr_blocks" {
  description = "The CIDR blocks of the subnets"
  value       = aws_subnet.subnet[*].cidr_block
}

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = aws_security_group.sg[*].id
}

output "route_table_ids" {
  description = "The IDs of the route tables"
  value       = aws_route_table.example[*].id
}
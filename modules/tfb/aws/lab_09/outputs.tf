output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Outputs for count-based resources
output "subnet_count_ids" {
  description = "The IDs of the count-based subnets"
  value       = aws_subnet.subnet[*].id
}

# Outputs for for_each-based resources (map)
output "subnet_foreach_ids" {
  description = "The IDs of the for_each-based subnets"
  value       = aws_subnet.subnet_foreach
}

output "security_group_foreach_ids" {
  description = "The IDs of the for_each-based security groups"
  value       = aws_security_group.sg_foreach
}

# Outputs for simple map-based resources
output "route_table_ids" {
  description = "The IDs of the map-based route tables"
  value       = aws_route_table.rt
}
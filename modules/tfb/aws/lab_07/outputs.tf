output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_a_id" {
  description = "The ID of public subnet in AZ a"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "The ID of public subnet in AZ b"
  value       = aws_subnet.public_b.id
}

output "private_subnet_a_id" {
  description = "The ID of private subnet in AZ a"
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "The ID of private subnet in AZ b"
  value       = aws_subnet.private_b.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.web.id
}
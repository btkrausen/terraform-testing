output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.production.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = aws_subnet.private.id
}

output "availability_zone" {
  description = "Availability zone of the subnet"
  value       = aws_subnet.private.availability_zone
}

output "account_info" {
  description = "AWS Account Information"
  value       = "${data.aws_caller_identity.current.account_id} (${data.aws_region.current.name})"
}
output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.policy.arn
}

output "policy_name" {
  description = "Name of the IAM policy"
  value       = aws_iam_policy.policy.name
}

output "policy_id" {
  description = "ID of the IAM policy"
  value       = aws_iam_policy.policy.id
}
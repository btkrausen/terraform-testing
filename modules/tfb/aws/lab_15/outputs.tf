output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "role_name" {
  description = "Name of the created IAM role"
  value       = aws_iam_role.example.name
}

output "policy_name" {
  description = "Name of the created IAM policy"
  value       = aws_iam_policy.example.name
}
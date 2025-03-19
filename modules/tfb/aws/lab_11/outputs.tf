output "primary_bucket_name" {
  description = "Name of the S3 bucket in the primary region"
  value       = aws_s3_bucket.primary.bucket
}

output "secondary_bucket_name" {
  description = "Name of the S3 bucket in the secondary region"
  value       = aws_s3_bucket.secondary.bucket
}

output "primary_bucket_region" {
  description = "Region of the primary S3 bucket"
  value       = aws_s3_bucket.primary.region
}

output "secondary_bucket_region" {
  description = "Region of the secondary S3 bucket"
  value       = aws_s3_bucket.secondary.region
}

output "primary_sns_topic_arn" {
  description = "ARN of the SNS topic in the primary region"
  value       = aws_sns_topic.primary.arn
}

output "secondary_sns_topic_arn" {
  description = "ARN of the SNS topic in the secondary region"
  value       = aws_sns_topic.secondary.arn
}
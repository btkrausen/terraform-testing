variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "tf-lab16"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "lab_name" {
  description = "Lab identifier for tagging"
  type        = string
  default     = "lab16"
}

variable "random_suffix_length" {
  description = "Length of random suffix for unique resource names"
  type        = number
  default     = 8
}

variable "assume_role_service" {
  description = "Service that can assume the IAM role"
  type        = string
  default     = "s3.amazonaws.com"
}

variable "policy_actions" {
  description = "List of actions to allow in the IAM policy"
  type        = list(string)
  default     = ["s3:ListBucket"]
}

variable "bucket_tag_name" {
  description = "Name tag for the bucket"
  type        = string
  default     = "example-bucket"
}

variable "effect_type" {
  description = "Effect type for IAM policies"
  type        = string
  default     = "Allow"
}

variable "policy_description" {
  description = "Description for the IAM policy"
  type        = string
  default     = "Example policy for lab exercises"
}

variable "special_chars_allowed" {
  description = "Allow special characters in random string"
  type        = bool
  default     = false
}

variable "upper_chars_allowed" {
  description = "Allow uppercase characters in random string"
  type        = bool
  default     = false
}
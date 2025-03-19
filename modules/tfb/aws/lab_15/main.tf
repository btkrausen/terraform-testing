# Add resource blocks below
# Create IAM policies using the iam_policy module directly, without variables
module "s3_read_only_policy" {
  source             = "./modules/iam_policy"
  environment        = var.environment
  policy_name        = "s3-read-only"
  policy_description = "Allow read-only access to S3"
  policy_statements = [
    {
      effect    = "Allow"
      actions   = ["s3:Get*", "s3:List*"]
      resources = ["*"]
    }
  ]
}

module "cloudwatch_write_policy" {
  source             = "./modules/iam_policy"
  environment        = var.environment
  policy_name        = "cloudwatch-write"
  policy_description = "Allow CloudWatch write access"
  policy_statements = [
    {
      effect    = "Allow"
      actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      resources = ["*"]
    }
  ]
}

# Create IAM roles and associate with policies
module "app_role" {
  source            = "./modules/iam_role"
  environment       = var.environment
  role_name         = "app-role"
  role_description  = "Application role"
  trusted_principal = "ec2.amazonaws.com"
  policy_arns       = [module.s3_read_only_policy.policy_arn]
}

module "monitoring_role" {
  source            = "./modules/iam_role"
  environment       = var.environment
  role_name         = "monitoring-role"
  role_description  = "Monitoring role"
  trusted_principal = "lambda.amazonaws.com"
  policy_arns       = [module.cloudwatch_write_policy.policy_arn]
}
resource "aws_iam_policy" "policy" {
  name        = "${var.environment}-${var.policy_name}"
  path        = "/"
  description = var.policy_description

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for statement in var.policy_statements : {
        Effect   = statement.effect
        Action   = statement.actions
        Resource = statement.resources
      }
    ]
  })

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "iam_policy"
    Name        = "${var.environment}-${var.policy_name}"
  }
}
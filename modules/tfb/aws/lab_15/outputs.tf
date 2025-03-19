# Add outputs below
output "policy_arns" {
  description = "ARNs of the created IAM policies"
  value = {
    s3_read_only     = module.s3_read_only_policy.policy_arn,
    cloudwatch_write = module.cloudwatch_write_policy.policy_arn
  }
}

output "role_arns" {
  description = "ARNs of the created IAM roles"
  value = {
    app_role        = module.app_role.role_arn,
    monitoring_role = module.monitoring_role.role_arn
  }
}

output "role_names" {
  description = "Names of the created IAM roles"
  value = {
    app_role        = module.app_role.role_name,
    monitoring_role = module.monitoring_role.role_name
  }
}
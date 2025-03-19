variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy"
  type        = string
}

variable "policy_statements" {
  description = "List of policy statements"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
}
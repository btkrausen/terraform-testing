module "repository" {
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  name        = "${var.environment}-app"
  description = "Application repository for ${var.environment} environment"
  topics      = ["terraform", "application", var.environment]
  visibility  = var.repository_visibility
  archived    = false
}

module "default-branch-protection" {
  source  = "masterborn/default-branch-protection/github"
  version = "1.1.0"

  repository_name = split("/", module.repository.full_name)[1]
}



module "user-repositories" {
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  for_each    = var.user_repos
  name        = "${each.value}-${var.environment}-app"
  description = "Application repository for ${var.environment} environment"
  topics      = ["terraform", "application", var.environment]
  visibility  = var.repository_visibility
  archived    = false
}

module "user-default-branch-protection" {
  source  = "masterborn/default-branch-protection/github"
  version = "1.1.0"

  for_each        = var.user_repos
  repository_name = split("/", module.user-repositories[each.key].full_name)[1]
}
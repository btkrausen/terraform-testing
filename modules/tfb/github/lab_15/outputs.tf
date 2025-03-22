# Add outputs below
output "repository_urls" {
  description = "URLs of the created repositories"
  value = {
    api      = module.api_repository.html_url,
    frontend = module.frontend_repository.html_url
  }
}

output "protected_branches" {
  description = "Information about protected branches"
  value = {
    api      = "${module.api_branch_protection.repository_name}:${module.api_branch_protection.protected_branch}",
    frontend = "${module.frontend_branch_protection.repository_name}:${module.frontend_branch_protection.protected_branch}"
  }
}

output "clone_urls" {
  description = "Clone URLs for the repositories"
  value = {
    api = {
      ssh   = module.api_repository.ssh_clone_url,
      https = module.api_repository.git_clone_url
    },
    frontend = {
      ssh   = module.frontend_repository.ssh_clone_url,
      https = module.frontend_repository.git_clone_url
    }
  }
}
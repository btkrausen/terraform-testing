output "repository_urls" {
  description = "URLs of the created repositories"
  value       = github_repository.repo[*].html_url
}

output "repository_names" {
  description = "Names of the created repositories"
  value       = github_repository.repo[*].name
}

output "protection_repository_ids" {
  description = "IDs of repositories with branch protection"
  value       = github_branch_protection.protection[*].repository_id
}
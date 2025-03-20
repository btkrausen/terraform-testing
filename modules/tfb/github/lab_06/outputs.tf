output "repository_url" {
  description = "URL of the created repository"
  value       = github_repository.production.html_url
}

output "creator_info" {
  description = "Information about who created the resources"
  value       = data.github_user.current.login
}
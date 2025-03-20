output "app_repo_url" {
  description = "URL of the application repository"
  value       = github_repository.app.html_url
}

output "docs_repo_url" {
  description = "URL of the documentation repository"
  value       = github_repository.docs.html_url
}

output "current_user" {
  description = "Username of the authenticated user"
  value       = data.github_user.current.login
}
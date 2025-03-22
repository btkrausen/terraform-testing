output "repository_urls" {
  description = "URLs of the created repositories"
  value       = github_repository.main[*].html_url
}

output "repository_count" {
  description = "Number of repositories created (using min function)"
  value       = min(3, length(var.repository_names))
}

output "unique_team_members" {
  description = "List of unique team members (using toset function)"
  value       = local.unique_members
}

output "repo_urls" {
  description = "A map of each user's repo HTML URL"
  value = {
    for username, repo in github_repository.example : username => repo.html_url
  }
}
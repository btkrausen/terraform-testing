output "repo_details_read_only" {
  description = "Repository details retrieved with read-only token"
  value = {
    name        = data.github_repository.read_only_repo.name
    description = data.github_repository.read_only_repo.description
    url         = data.github_repository.read_only_repo.html_url
  }
}
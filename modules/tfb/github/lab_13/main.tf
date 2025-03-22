# Add resources for the lab below
# Use join function to create repository names
resource "github_repository" "main" {
  count       = min(3, length(var.repository_names))
  name        = join("-", [var.environment, var.repository_names[count.index]])
  description = "Repository for ${var.repository_names[count.index]}"
  visibility  = "public"
  auto_init   = true

  # This creates repos like "dev-api", "dev-web", etc. using the join function
}

# Use toset function to remove duplicates from team members list
locals {
  unique_members = toset(var.team_members)
}

resource "github_repository" "example" {
  for_each = local.unique_members

  name        = join("-", [var.environment, each.value])
  description = "Repo for ${each.value} to store code"
  visibility  = "public"
  auto_init   = true
}


# Use join for topic descriptions
resource "github_repository_file" "readme" {
  count              = min(3, length(var.repository_names))
  repository         = github_repository.main[count.index].name
  branch             = "main"
  file               = "README.md"
  content            = <<-EOT
    # ${upper(var.repository_names[count.index])}
    
    This is the ${var.repository_names[count.index]} repository.
    
    Topics: ${join(", ", var.topics)}
  EOT
  commit_message     = "Add README with topics"
  commit_author      = "Terraform"
  commit_email       = "terraform@example.com"
  overwrite_on_create = true
}
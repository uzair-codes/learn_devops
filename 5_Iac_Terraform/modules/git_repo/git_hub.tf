#### Example Terraform code to create a GitHub repository using the GitHub provider ####
# terraform {
#   required_providers {
#     github = {
#       source  = "integrations/github"
#       version = "6.11.1"
#     }
#   }
# }

# # Configure GitHub Provider
# provider "github" {
#   token = var.github_token
# }

# Create GitHub Repository
resource "github_repository" "devops_course" {

  name        = "learn_DevOps"
  description = "My awesome DevOps Course"

  visibility = "public" # Repository visibility (public or private)

  # auto_init = true # Initialize the repository with a README file

}
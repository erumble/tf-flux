module "flux" {
  source = "./modules/flux"

  github_owner         = var.flux_github_owner
  github_repository    = var.flux_github_repository
  github_path          = terraform.workspace
  github_branch        = terraform.workspace
  create_github_branch = true
}


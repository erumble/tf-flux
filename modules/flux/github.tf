# Github Repo Info
data "github_repository" "flux_config" {
  full_name = local.github_repo
}

data "github_branch" "flux_config" {
  count = var.create_github_branch ? 0 : 1

  repository = data.github_repository.flux_config.name
  branch     = var.github_branch
}

resource "github_branch" "flux_config" {
  count = var.create_github_branch ? 1 : 0

  repository = data.github_repository.flux_config.name
  branch     = var.github_branch
}

# Flux Configuration Files
resource "github_repository_file" "install" {
  count = var.commit_flux_manifests ? 1 : 0

  repository          = data.github_repository.flux_config.name
  file                = data.flux_install.main.path
  content             = data.flux_install.main.content
  branch              = local.github_branch
  overwrite_on_create = true
}

resource "github_repository_file" "sync" {
  count = var.commit_flux_manifests ? 1 : 0

  repository          = data.github_repository.flux_config.name
  file                = data.flux_sync.main.path
  content             = data.flux_sync.main.content
  branch              = local.github_branch
  overwrite_on_create = true
}

resource "github_repository_file" "kustomize" {
  count = var.commit_flux_manifests ? 1 : 0

  repository          = data.github_repository.flux_config.name
  file                = data.flux_sync.main.kustomize_path
  content             = data.flux_sync.main.kustomize_content
  branch              = local.github_branch
  overwrite_on_create = true
}

# Flux Deploy Key
resource "github_repository_deploy_key" "main" {
  title      = "flux-deploy-key"
  repository = data.github_repository.flux_config.name
  key        = tls_private_key.flux_deploy_key.public_key_openssh
  read_only  = true
}


locals {
  flux_branch = "flux-${terraform.workspace}"
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "flux" {
  title      = "flux"
  repository = var.flux_github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

resource "github_branch" "flux" {
  repository    = var.flux_github_repository
  branch        = local.flux_branch
  source_branch = var.flux_source_branch
}

resource "flux_bootstrap_git" "this" {
  path = "flux/clusters/${terraform.workspace}"

  depends_on = [
    github_branch.flux,
    github_repository_deploy_key.flux,
  ]
}

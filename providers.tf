# This file contains provider configuration
# Provider version and source info can be found in versions.tf

provider "flux" {
  kubernetes = {
    host                   = kind_cluster.this.endpoint
    client_certificate     = kind_cluster.this.client_certificate
    client_key             = kind_cluster.this.client_key
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
  }

  git = {
    url    = "ssh://git@github.com/${var.github_org}/${var.flux_github_repository}.git"
    branch = local.flux_branch

    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

# Credentials sourced from logging in with the Github CLI
provider "github" {
  owner = var.github_org
}

provider "kind" {}

provider "tls" {}

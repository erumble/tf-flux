# This file contains provider configuration
# Provider version and source info can be found in versions.tf

provider "flux" {
  # kubernetes = k3d_cluster.this.credentials[0]
  kubernetes = {
    host                   = k3d_cluster.this.credentials[0].host
    client_certificate     = k3d_cluster.this.credentials[0].client_certificate
    client_key             = k3d_cluster.this.credentials[0].client_key
    cluster_ca_certificate = k3d_cluster.this.credentials[0].cluster_ca_certificate
  }

  git = {
    url    = "ssh://git@github.com/${var.github_org}/${var.flux_github_repository}.git"
    branch = "k3d-${var.cluster_name}"

    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

# Credentials sourced from GITHUB_TOKEN
provider "github" {
  owner = var.github_org
}

provider "k3d" {}

provider "random" {}

provider "tls" {}

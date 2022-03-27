# This file contains provider configuration
# Provider version and source info can be found in versions.tf

provider "flux" {}

# Credentials sourced from GITHUB_TOKEN and GITHUB_OWNER
provider "github" {}

provider "helm" {
  kubernetes {
    config_path    = var.kubernetes_config_path
    config_context = var.kubernetes_config_context
  }
}

provider "kubectl" {}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path
  config_context = var.kubernetes_config_context
}


terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 0.11"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.22"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.13"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.9"
    }
  }
}


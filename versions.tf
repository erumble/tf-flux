terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.42"
    }

    k3d = {
      source  = "pvotal-tech/k3d"
      version = "0.0.7"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }

    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

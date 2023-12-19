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

    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

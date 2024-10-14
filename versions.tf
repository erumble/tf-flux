terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }

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

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31"
    }

    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "~> 4.0"
    # }
  }
}

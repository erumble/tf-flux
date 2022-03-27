variable "kubernetes_config_context" {
  description = "Config context to use to connect to kubernetes cluster."
  type        = string
}

variable "kubernetes_config_path" {
  description = "Path to kube config file."
  type        = string
  default     = "~/.kube/config"
}

variable "flux_github_owner" {
  description = "Owner of Github repository containing Flux configuration."
  type        = string
  default     = "erumble"
}

variable "flux_github_repository" {
  description = "Name of repository containing Flux configuration."
  type        = string
  default     = "flux-infra"
}


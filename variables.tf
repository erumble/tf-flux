variable "github_org" {
  description = "Name of the Github organization where Flux config is located."
  type        = string
  default     = "erumble"
}

variable "flux_github_repository" {
  description = "Name of repository containing Flux configuration."
  type        = string
  default     = "tf-flux"
}

variable "flux_source_branch" {
  description = "Source branch to create flux branch from."
  type        = string
  default     = "main"
}

# k8s cluster variables
variable "agent_count" {
  description = "The number of worker nodes to run in the cluster."
  type        = number
  default     = 3
}

variable "kube_config_path" {
  description = "Absolute path to your kube config file."
  type        = string
  default     = "~/.kube/config"
}

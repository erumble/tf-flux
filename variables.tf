# variable "github_token" {
#   description = "Personal Access Token with `repo` scope, used for accessing Github resources."
#   type      = string
#   sensitive = true
# }

variable "github_org" {
  description = "Name of the Github organization where Flux config is located."
  type = string
  default = "erumble"
}

variable "flux_github_repository" {
  description = "Name of repository containing Flux configuration."
  type = string
  default = "tf-k3s"
}

# k8s cluster variables
variable "cluster_name" {
  description = "The name of the cluster to create."
  type        = string
  default     = "dev"
}

variable "agent_count" {
  description = "The number of worker nodes to run in the cluster."
  type        = number
  default     = 3
}

variable "server_count" {
  description = "The number of control plane nodes to run in the cluster."
  type        = number
  default     = 1
}

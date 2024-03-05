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

variable "control_plane_port_mappings" {
  description = "List of extra port mappings to expose on the control plane. Useful for setting up ingress gateways."

  type = list(object({
    container_port = number
    host_port      = number
    listen_address = optional(string, "127.0.0.1")
    protocol       = optional(string, "TCP")
  }))

  default = []

  validation {
    condition     = alltrue([for cp in var.control_plane_port_mappings : contains(["TCP", "UDP", "SCTP", null], cp.protocol)])
    error_message = "Protocol must be one of [\"TCP\", \"UDP\", \"SCTP\"]."
  }
}

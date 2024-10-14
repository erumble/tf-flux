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
  default     = "dev"
}

# k8s cluster variables
variable "agent_count" {
  description = "The number of worker nodes to run in the cluster."
  type        = number
  default     = 3
}

variable "cluster_name" {
  description = "The name of the Kind cluster to create."
  type        = string
  default     = "local-kind"
}

variable "control_plane_http_ingress_port_mapping" {
  description = "Node port to expose on host for HTTP ingress."

  type = object({
    container_port = number
    host_port      = number
  })

  default = {
    container_port = 32080
    host_port      = 80
  }
}

variable "control_plane_https_ingress_port_mapping" {
  description = "Node port to expose on host for HTTP ingress."

  type = object({
    container_port = number
    host_port      = number
  })

  default = {
    container_port = 32443
    host_port      = 443
  }
}

variable "control_plane_labels" {
  description = "Labels to apply to the control plane node."
  type        = map(string)

  default = {
    ingress-controller = "true"
  }
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

variable "kube_config_path" {
  description = "Absolute path to your kube config file."
  type        = string
  default     = "~/.kube/config"
}

variable "local_registry" {
  description = "Configuration for using a local docker registry."

  type = object({
    enabled = optional(bool, false)
    port    = optional(number, 5001)
  })

  default = {}
}

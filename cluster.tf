resource "kind_cluster" "this" {
  name            = var.cluster_name
  kubeconfig_path = abspath(pathexpand(var.kube_config_path))
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      labels = {
        ingress-controller : "true"
      }

      extra_port_mappings {
        container_port = 32080
        host_port      = 80
        listen_address = "127.0.0.1"
      }

      extra_port_mappings {
        container_port = 32443
        host_port      = 443
        listen_address = "127.0.0.1"
      }
    }

    dynamic "node" {
      for_each = range(var.agent_count)

      content {
        role = "worker"
      }
    }
  }
}

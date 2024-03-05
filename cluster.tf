resource "kind_cluster" "this" {
  name            = terraform.workspace
  kubeconfig_path = abspath(pathexpand(var.kube_config_path))
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      labels = {
        ingress-controller = "true"
      }

      dynamic "extra_port_mappings" {
        for_each = { for epm in var.control_plane_port_mappings : "${epm.host_port}-${epm.container_port}" => epm }

        content {
          container_port = extra_port_mappings.value.container_port
          host_port      = extra_port_mappings.value.host_port
          listen_address = extra_port_mappings.value.listen_address
          protocol       = extra_port_mappings.value.protocol
        }
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

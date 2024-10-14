resource "kind_cluster" "this" {
  name            = var.cluster_name
  kubeconfig_path = abspath(pathexpand(var.kube_config_path))
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    containerd_config_patches = var.local_registry.enabled ? [
      <<-TOML
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${var.local_registry.port}"]
        endpoint = ["http://${var.cluster_name}-registry:5000"]
      TOML
    ] : []

    node {
      role = "control-plane"

      labels = merge({
        ingress-controller = "true"
      }, var.control_plane_labels)

      extra_port_mappings {
        container_port = var.control_plane_http_ingress_port_mapping.container_port
        host_port      = var.control_plane_http_ingress_port_mapping.host_port
      }

      extra_port_mappings {
        container_port = var.control_plane_https_ingress_port_mapping.container_port
        host_port      = var.control_plane_https_ingress_port_mapping.host_port
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

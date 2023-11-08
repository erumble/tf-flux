resource "random_id" "machine_id" {
  byte_length = 16
}

resource "local_file" "machine_id" {
  filename        = "${path.module}/files/machine-id"
  content         = "${random_id.machine_id.hex}\n"
  file_permission = "0644"
}

resource "k3d_cluster" "this" {
  name = var.cluster_name

  agents  = var.agent_count
  servers = var.server_count

  kubeconfig {
    switch_current_context    = true
    update_default_kubeconfig = true
  }

  port {
    host_port      = 8080
    container_port = 80

    node_filters = [
      "loadbalancer",
    ]
  }

  port {
    host_port      = 8443
    container_port = 443

    node_filters = [
      "loadbalancer",
    ]
  }

  volume {
    source      = abspath(local_file.machine_id.filename)
    destination = "/etc/machine-id"
  }
}

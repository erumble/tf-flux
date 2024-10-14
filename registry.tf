resource "docker_image" "registry" {
  count = var.local_registry.enabled ? 1 : 0

  name = "registry:2"
}

resource "docker_container" "registry" {
  count = var.local_registry.enabled ? 1 : 0

  name         = "${var.cluster_name}-registry"
  image        = docker_image.registry[0].image_id
  restart      = "always"
  network_mode = "bridge"

  ports {
    internal = 5000
    ip       = "127.0.0.1"
    external = var.local_registry.port
  }

  networks_advanced {
    name = data.docker_network.kind.name
  }
}

resource "kubernetes_config_map" "local_registry_hosting" {
  count = var.local_registry.enabled ? 1 : 0

  metadata {
    name      = "local-registry-hosting"
    namespace = "kube-public"
  }

  data = {
    "localRegistryHosting.v1" = <<-YAML
      host: "localhost:${var.local_registry.port}"
      help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
    YAML
  }
}

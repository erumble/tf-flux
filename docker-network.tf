# Kind creates a network called "kind"
# we want the registry container and git server to be in the same network

data "docker_network" "kind" {
  name = "kind"

  depends_on = [
    kind_cluster.this,
  ]
}

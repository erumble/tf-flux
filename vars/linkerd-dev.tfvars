# Variables for the linkerd-dev workspace
control_plane_port_mappings = [
  {
    container_port = 32080
    host_port      = 80
  },
  {
    container_port = 32443
    host_port      = 443
  },
]

# Variables for the istio workspace
control_plane_port_mappings = [
  {
    container_port = 80
    host_port      = 80
  },
  {
    container_port = 443
    host_port      = 443
  },
]

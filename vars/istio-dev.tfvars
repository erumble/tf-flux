# Variables for the istio workspace
flux_source_branch = "istio"

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

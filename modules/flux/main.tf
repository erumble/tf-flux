resource "kubernetes_namespace" "flux" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

# Flux install resources
data "flux_install" "main" {
  target_path = local.github_path
  namespace   = var.namespace
}

data "kubectl_file_documents" "flux_install" {
  content = data.flux_install.main.content
}

resource "kubectl_manifest" "flux_install" {
  for_each = local.flux_install_manifests

  yaml_body = each.value

  depends_on = [
    kubernetes_namespace.flux,
  ]
}

# Flux sync resources
data "flux_sync" "main" {
  target_path = local.github_path
  url         = "ssh://git@github.com/${local.github_repo}.git"
  branch      = var.github_branch
  namespace   = var.namespace
}

data "kubectl_file_documents" "flux_sync" {
  content = data.flux_sync.main.content
}

resource "kubectl_manifest" "flux_sync" {
  for_each = local.flux_sync_manifests

  yaml_body = each.value

  depends_on = [
    kubernetes_namespace.flux,
  ]
}

# SSH key Flux uses to sync with the target repo
resource "tls_private_key" "flux_deploy_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "kubernetes_secret" "flux_deploy_key" {
  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    identity       = tls_private_key.flux_deploy_key.private_key_pem
    "identity.pub" = tls_private_key.flux_deploy_key.public_key_pem
    known_hosts    = local.known_hosts
  }

  depends_on = [
    kubectl_manifest.flux_install,
  ]
}


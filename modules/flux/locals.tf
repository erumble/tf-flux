locals {
  flux_install_manifests = { for m in [for d in data.kubectl_file_documents.flux_install.documents : {
    data : yamldecode(d)
    content : d
  }] : lower(join("/", compact([m.data.apiVersion, m.data.kind, lookup(m.data.metadata, "namespace", ""), m.data.metadata.name]))) => m.content }

  flux_sync_manifests = { for m in [for d in data.kubectl_file_documents.flux_sync.documents : {
    data : yamldecode(d)
    content : d
  }] : lower(join("/", compact([m.data.apiVersion, m.data.kind, lookup(m.data.metadata, "namespace", ""), m.data.metadata.name]))) => m.content }

  github_branch = var.create_github_branch ? github_branch.flux_config[0].branch : data.github_branch.flux_config[0].branch
  github_path   = join("/", compact([var.github_path_prefix, var.github_path]))
  github_repo   = "${var.github_owner}/${var.github_repository}"

  known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}


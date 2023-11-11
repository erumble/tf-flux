# Use Terraform and K3d to manage a K3s Cluster

This will setup a k3d kubernetes cluster on your local machine and setup the following things.
* [Traefik](https://doc.traefik.io/traefik/) for ingress on [traefik.lvh.me:8080](http://traefik.lvh.me:8080)
* [Flux](https://fluxcd.io/) for gitops
* [Weave Gitops](https://docs.gitops.weave.works/docs/intro-weave-gitops/) to visualize flux on [flux.lvh.me:8080](http://flux.lvh.me:8080)
* [Linkerd](https://linkerd.io/) for a service mesh
* [Cert Manager](https://cert-manager.io/docs/) for good old SSL and mTLS
* [Podinfo](https://github.com/stefanprodan/podinfo) to test that everything is working on [podinfo.lvh.me:8080](http://podinfo.lvh.me:8080)

## Prerequisites
* [K3d](https://k3d.io)
* [Terraform](https://www.terraform.io/docs/index.html)

This Terraform project uses the Github provider. In order to authenticate to Github, you will need to do 1 of the following:
* Install the [Github CLI](https://cli.github.com/) and authenticate through that
* Create a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) with the `repo` scope, and set the `GITHUB_TOKEN` env var to your PAT.

## Usage
Setup
```
terraform apply
```

Cleanup
```
terraform destroy
```

See the [Flux README](flux/README.md) for more information on how flux works, and how the directory structure is set up.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.42 |
| <a name="requirement_k3d"></a> [k3d](#requirement\_k3d) | 0.0.7 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_flux"></a> [flux](#provider\_flux) | 1.1.2 |
| <a name="provider_github"></a> [github](#provider\_github) | 5.42.0 |
| <a name="provider_k3d"></a> [k3d](#provider\_k3d) | 0.0.7 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [flux_bootstrap_git.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/resources/bootstrap_git) | resource |
| [github_branch.flux](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_repository_deploy_key.flux](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [k3d_cluster.this](https://registry.terraform.io/providers/pvotal-tech/k3d/0.0.7/docs/resources/cluster) | resource |
| [local_file.machine_id](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_id.machine_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [tls_private_key.flux](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_count"></a> [agent\_count](#input\_agent\_count) | The number of worker nodes to run in the cluster. | `number` | `3` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to create. | `string` | `"dev"` | no |
| <a name="input_flux_github_repository"></a> [flux\_github\_repository](#input\_flux\_github\_repository) | Name of repository containing Flux configuration. | `string` | `"tf-k3d"` | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Name of the Github organization where Flux config is located. | `string` | `"erumble"` | no |
| <a name="input_server_count"></a> [server\_count](#input\_server\_count) | The number of control plane nodes to run in the cluster. | `number` | `1` | no |

## Outputs

No outputs.

This README was generated by [terraform-docs](https://terraform-docs.io).
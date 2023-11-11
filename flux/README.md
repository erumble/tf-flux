# Flux!

Flux is the gitops tool of choice, mostly because of the following:
* Specific CRDs for various code/artifact resources
* Specific CRDs for deploying applications
* Native Helm support

## The Directory Structure
```
flux
├── README.md
├── apps
│   ├── base
│   │   └── podinfo
│   │       ├── application.yaml
│   │       └── kustomization.yaml
│   └── dev
│       ├── kustomization.yaml
│       └── podinfo-values.yaml
├── clusters
│   └── dev
│       ├── apps.yaml
│       └── infra.yaml
└── infrastructure
    ├── configs
    │   └── dev
    │       ├── ca-issuer.yaml
    │       ├── kustomization.yaml
    │       └── traefik-dashboard.yaml
    └── controllers
        ├── base
        │   ├── cert-manager
        │   │   ├── application.yaml
        │   │   └── kustomization.yaml
        │   └── weave-gitops
        │       ├── application.yaml
        │       └── kustomization.yaml
        └── dev
            ├── kustomization.yaml
            └── weave-gitops-values.yaml
```

### The Top Level Directories

---

*Apps* - This directory should contain application configuration for apps that are served by the k8s cluster.
These apps should not provide any CRDs for the cluster, and should not be operators for the cluster.

```
flux/apps
├── base
│   └── podinfo
│       ├── application.yaml
│       └── kustomization.yaml
└── dev
    ├── kustomization.yaml
    └── podinfo-values.yaml
```

Application definitions are placed in `flux/apps/base`, each in their own folder. The `application.yaml` is a manifest of the Flux CRDs necessary to install the application, and `kustomization.yaml` is the "entrypoint" for Flux to find the `application.yaml` file. In general, `kustomization.yaml` should be the same across all apps.

Cluster specific application configuration is placed in the `flux/apps/<cluster-name>` directory. The `kustomization.yaml` file in this directory will be unique for each cluster, as well any ancillary files in the directory.

---

*Clusters* - This directory contains the configuration and bootstrap code for the clusters themselves. This directory should largely be unchanged.

```
flux/clusters
└── dev
    ├── apps.yaml
    └── infra.yaml
```

`apps.yaml` and `infra.yaml` are entrypoints for Flux to install things listed in the `apps` and `infrastructure` directories. They establish a dependency order to install `infrastructure/controllers`, then `infrastructure/configs`, and finally `apps` for the respective clusters.

---

*infrastructure* - This directory should contain cluster applications/operators/controllers as well as configuration of resources (CRDs) created by the controllers.

```
flux/infrastructure
├── configs
│   └── dev
│       ├── ca-issuer.yaml
│       ├── kustomization.yaml
│       └── traefik-dashboard.yaml
└── controllers
    ├── base
    │   ├── cert-manager
    │   │   ├── application.yaml
    │   │   └── kustomization.yaml
    │   ├── metrics-server
    │   │   ├── application.yaml
    │   │   └── kustomization.yaml
    │   └── weave-gitops
    │       ├── application.yaml
    │       └── kustomization.yaml
    └── dev
        ├── kustomization.yaml
        └── weave-gitops-values.yaml
```

This directory is split into two parts so that Flux can have a dependency order. Essentially, anything in the `controllers` directory should install operators/controllers and their respective CRDs, and the things in `configs` should instantiate those CRDs to configure the cluster.

The `controllers` directory is laid out exactly the same as the `flux/apps` directory, and should be treated the same way. Except these are usually infrastructure related applications.

The `configs` directory is for instantiating CRDs defined by the applications in the `controllers` directory. An example of this is using configs to create a CA Issuer for self signed certificates managed by Cert Manager. The files in this directory will also be cluster specific, similar to all of the other `<dir>/<cluster-name>` directories.

---

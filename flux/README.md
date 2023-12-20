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
│       └── controllers.yaml
└── controllers
    ├── base
    │   ├── cert-manager
    │   │   ├── application.yaml
    │   │   └── kustomization.yaml
    │   ├── linkerd
    │   ├── metrics-server
    │   ├── traefik
    │   └── weave-gitops
    └── overlays
        └── dev
            ├── cert-manager
            │   └── kustomization.yaml
            ├── linkerd
            ├── traefik
            └── weave-gitops
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
    └── controllers.yaml
```

`apps.yaml` and `controllers.yaml` are entrypoints for Flux to install things listed in the `apps` and `controllers` directories. They establish a dependency order to install `controllers`, then `apps` for the respective clusters.

---

*controllers* - This directory should contain cluster applications/operators/controllers as well as configuration of resources (CRDs) created by the controllers.

```
flux/controllers
├── base
│   ├── cert-manager
│   │   ├── application.yaml
│   │   └── kustomization.yaml
│   ├── linkerd
│   │   └── ...
│   └── ...
└── overlays
    └── dev
        ├── cert-manager
        │   └── kustomization.yaml
        ├── linkerd
        │   └── ...
        └── ...
```

This directory is split into two parts so that Flux can have a dependency order, and each cluster controlled by this repo can have specific configuration.

The `base` directory is laid out exactly the same as the `flux/apps/base` directory, and should be treated the same way. Except these are usually infrastructure related applications.

The `overlays` directory is for instantiating applications defined in the `base` directory for a specific cluster. This is where cluster specific Helm values will be kept for the applications in `controllers/base`

---

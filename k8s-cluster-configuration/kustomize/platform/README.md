# Platform Configuration Pattern

This directory defines cluster platform services with Argo CD and Kustomize.
The platform is split into two parts:

- `argocd/` bootstraps or self-manages Argo CD.
- `core/` is the platform app-of-apps for cluster services.

## How It Works

`core/kustomization.yml` lists the enabled platform components. The current
enabled set is the bare minimum needed for this cluster: routing, certificates,
DNS, sealed secrets, config reloads, registry, and baseline policies.

Each component is an Argo CD `Application` that points at its own `base/`
directory. The `core/meta` config injects the shared repo URL, revision,
destination cluster, and app-of-apps label into those child Applications.

## How To Use It

1. Enable a platform component by uncommenting its `application.yml` in
   `core/kustomization.yml`.
2. Configure the component in its `base/values.yml` and related manifests.
3. Keep component-specific secrets sealed or externally managed.
4. Add new components under `core/components/<category>/<name>/` with an
   `application.yml` and a `base/kustomization.yml`.

Keep this layer for shared cluster capabilities. Product and customer workloads
belong in `kustomize/applications`.


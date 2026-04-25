# Application Configuration Pattern

This directory is the template for adding product/customer workloads to Argo CD.
Each workload is its own Argo CD `Application`, and the root `kustomization.yml`
collects those applications into one app-of-apps.

## Layout

```text
applications/
  kustomization.yml
  app-of-apps.yml
  <group>/
    <app>/
      application.yml
      base/
        kustomization.yml
        deployment.yml
        service.yml
        gateway.yml
```

Use groups to keep ownership clear, for example `company-applications/` or a
customer folder. Keep one deployable app per folder.

## How To Add An App

1. Copy one of the example application folders.
2. Rename the Argo CD `Application`, namespace, Kubernetes object names, labels,
   image, hostnames, and certificate names.
3. Point `spec.source.path` at the app's `base/` directory.
4. Add the app directory to the root `kustomization.yml`.
5. Keep app manifests in `base/`; use overlays only when the app really has
   environment-specific differences.

## Conventions

- `application.yml` owns Argo CD behavior: source, destination namespace, and
  sync options.
- `base/kustomization.yml` lists the Kubernetes resources for the app.
- `gateway.yml` should contain the app's `Certificate`, `Gateway`, and
  `HTTPRoute` when the app is public.
- Prefer Gateway API over Ingress.
- Use stable labels and selectors; do not reuse names across unrelated apps.
- Keep secrets out of plain YAML. Use Sealed Secrets or the platform secret
  management component.

# Agent Notes

When editing this tree, preserve the platform app-of-apps pattern.

- `platform/argocd` is for Argo CD itself.
- `platform/core` is for shared cluster services.
- Enable or disable platform services only through `core/kustomization.yml`
  unless the user asks for a different structure.
- New platform services should live under
  `core/components/<category>/<name>/`.
- Each service should have an Argo CD `application.yml` and a `base/`
  Kustomization.
- Keep `spec.source.path` aligned with the actual repo path under
  `k8s-cluster-configuration/kustomize/platform/...`.
- Do not put raw credentials in manifests. Use Sealed Secrets or external
  secret management.
- Do not add product or customer workloads here; those belong in
  `kustomize/applications`.


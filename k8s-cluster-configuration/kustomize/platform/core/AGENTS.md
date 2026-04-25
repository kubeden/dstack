# Agent Notes

This is the shared cluster services layer.

- Use `kustomization.yml` as the only enable/disable switch for components.
- Keep the bare-minimum enabled set small unless the user asks to expand it.
- Add new services under `components/<category>/<name>/`.
- Each component should expose an Argo CD `application.yml` and keep deployable
  resources in `base/`.
- Do not add application workloads here; use `kustomize/applications`.
- Keep secrets sealed or externally managed.
- Do not remove the `meta` resource or replacements block; they inject shared
  Argo CD source/destination fields into child Applications.
- When copying a component, update the Argo CD name, destination namespace,
  source path, Helm release name, chart values, and any secret names.


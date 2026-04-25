# Agent Notes

When editing this tree, preserve the app-of-apps pattern.

- Treat folders under `applications/` as examples unless the user says an app is
  real production configuration.
- Add or update apps by editing their `application.yml` and `base/` manifests.
- Register new app directories in `applications/kustomization.yml`.
- Keep `spec.source.path` aligned with the actual repo path under
  `k8s-cluster-configuration/kustomize/applications/...`.
- Do not put raw credentials in manifests. Use sealed or externally managed
  secrets.
- Do not make broad platform changes from this directory; platform components
  live under `kustomize/platform/core/components`.
- If copying an example, rename every app-specific value: Argo CD application
  name, namespace, labels, service names, gateway names, TLS secret names,
  hostnames, and image.

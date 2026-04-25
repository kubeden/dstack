# Agent Notes

- Keep reusable code under `modules/<provider>/<service>`.
- Keep deployable stacks under `providers/<provider>/<region>/<stack>`.
- Provider stacks should use `locals.tf`, `provider.tf`, `main.tf`, and
  `outputs.tf`.
- Modules should be split by resource type when they grow beyond a few
  resources.
- Do not put cloud resources in the Kubernetes GitOps tree.
- Do not make Terraform own Argo CD self-management or app-of-apps resources.
  The `*-argocd` stacks are Helm-only bootstrappers.
- Keep examples cost-conscious unless the user asks for production defaults.
- Keep raw credentials out of Terraform files.


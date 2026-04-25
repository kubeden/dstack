# Agent Notes

DStack is split into two responsibilities:

- IaC provisions cloud resources.
- GitOps configures Kubernetes resources.

Keep that boundary intact.

## IaC

Terraform lives in `infrastructure/terraform`.

- Use Terraform for remote state, networks, clusters, and Argo CD Helm bootstrap.
- Put reusable code in `modules/<provider>/<service>`.
- Put deployable stacks in `providers/<provider>/<region>/<stack>`.
- Keep provider stacks small: `locals.tf`, `provider.tf`, `main.tf`, `outputs.tf`.
- Do not make Terraform own Argo CD self-management, platform app-of-apps, or workloads.

## GitOps

Kustomize lives in `k8s-cluster-configuration/kustomize`.

- Use GitOps for Argo CD self-management, platform components, policies, and workloads.
- Put shared cluster services under `platform`.
- Put product/customer workloads under `applications`.
- Preserve the app-of-apps pattern.
- Keep raw credentials out of manifests; use sealed or external secrets.

## Checks

```sh
terraform fmt -check -recursive infrastructure/terraform
kustomize build k8s-cluster-configuration/kustomize/platform/core
kustomize build k8s-cluster-configuration/kustomize/applications
```


# Agent Notes

DStack is split into two responsibilities:

- IaC provisions cloud resources.
- GitOps configures Kubernetes resources.

Keep that boundary intact.

DStack is a starter template, not a production platform distribution.
Production hardening should be applied per environment.

## IaC

Terraform lives in `infrastructure/terraform`.

- Use Terraform for remote state, networks, clusters, and Argo CD Helm bootstrap.
- Put reusable code in `modules/<provider>/<service>`.
- Put deployable stacks in `providers/<provider>/<region>/<stack>`.
- Keep provider stacks small: `locals.tf`, `provider.tf`, `main.tf`, `outputs.tf`.
- Do not make Terraform own Argo CD self-management, platform app-of-apps, or workloads.
- Terraform modules may support production-oriented settings, but example
  provider stacks should stay minimal and cost-conscious unless asked otherwise.

## GitOps

Kustomize lives in `k8s-cluster-configuration/kustomize`.

- Use GitOps for Argo CD self-management, platform components, policies, and workloads.
- Put shared cluster services under `platform`.
- Put product/customer workloads under `applications`.
- Preserve the app-of-apps pattern.
- Keep raw credentials out of manifests; use sealed or external secrets.
- Keep the default platform baseline small. Optional commented components are
  available for observability, backup, autoscaling, supply-chain security,
  storage, and cloud integrations.

## Checks

```sh
terraform fmt -check -recursive infrastructure/terraform
kustomize build k8s-cluster-configuration/kustomize/platform/core
kustomize build k8s-cluster-configuration/kustomize/applications
```

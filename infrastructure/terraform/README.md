# Terraform

This directory is the infrastructure layer. It provisions cloud resources only;
Kubernetes platform configuration lives under `k8s-cluster-configuration`.

## Layout

```text
modules/
  aws/eks/       # reusable EKS module
  azure/aks/     # reusable AKS module
  hetzner/...    # reusable k3s-on-Hetzner modules

providers/
  aws/<region>/common/       # shared AWS state/common resources
  aws/<region>/eks/          # EKS cluster stack
  aws/<region>/eks-argocd/   # Helm-only Argo CD bootstrap
  azure/<region>/common/     # shared Azure state/common resources
  azure/<region>/aks/        # AKS cluster stack
  azure/<region>/aks-argocd/ # Helm-only Argo CD bootstrap
```

## Pattern

Provider stacks set concrete values in `locals.tf` and call reusable modules
from a small `main.tf`. Resource names are derived from:

- `customer_prefix`
- `region_code`
- `environment`
- `iteration`

Example prefix: `cc-weu-dev-01`.

## Bootstrap Order

1. Apply the cloud `common` stack to create remote state resources.
2. Apply the cluster stack: `eks`, `aks`, or k3s provider stack.
3. Apply the `*-argocd` stack to install Argo CD with Helm.
4. Wire Argo CD self-management, platform, DNS, and apps for the environment.

The Argo CD bootstrap stacks install only the Helm chart version declared in
`k8s-cluster-configuration/kustomize/platform/argocd/base/core/kustomization.yml`.
They do not apply Gateway, DNS, app-of-apps, or self-management resources.

## Checks

Run from the repository root:

```sh
terraform fmt -check -recursive infrastructure/terraform
```

Run from a specific provider stack directory:

```sh
terraform init -backend=false
terraform validate
```


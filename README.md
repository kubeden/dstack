# DStack

![the-dstack](./assets/the-dstack.png)

DStack is a Kubernetes platform template split into two logical processes:

1. **Provisioning** with IaC (Terraform).
2. **Configuration** with GitOps (ArgoCD).

DStack serves as the perfect ground base for a stable, highly-available & scalable container platform.

> TIP: Send this repository to your AI agent & discuss!

## 1. IaC

IaC lives in `infrastructure/terraform`.

Use it only to provision cloud resources:

- remote state resources
- networks
- Kubernetes clusters
- initial Argo CD Helm bootstrap

It should not own ongoing Kubernetes platform configuration.

```text
infrastructure/terraform/
  modules/      # reusable Terraform modules
  providers/    # deployable cloud stacks
```

## 2. GitOps

GitOps lives in `k8s-cluster-configuration/kustomize`.

Use it only to configure Kubernetes resources:

- Argo CD self-management
- platform components
- cluster policies
- workload Applications

```text
k8s-cluster-configuration/kustomize/
  platform/     # Argo CD and shared platform components
  applications/ # workload Application examples
```

## Flow

1. Apply the cloud `common` Terraform stack.
2. Apply the cluster Terraform stack: `eks`, `aks`, etc.
3. Apply the matching `*-argocd` Terraform stack.
4. Use GitOps to configure Argo CD, platform, and workloads.

## Checks

```sh
terraform fmt -check -recursive infrastructure/terraform

kustomize build k8s-cluster-configuration/kustomize/applications
kustomize build k8s-cluster-configuration/kustomize/platform/core
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/argocd/base/core
```

Run Terraform validation from a specific stack directory:

```sh
terraform init -backend=false
terraform validate
```

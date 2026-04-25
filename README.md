# Kubeden Infrastructure

Infrastructure and GitOps configuration for the Kubeden Kubernetes environment.

The repository has two main parts:

- `infrastructure/terraform`: provisions the cluster infrastructure and bootstraps k3s.
- `k8s-cluster-configuration/kustomize`: defines the cluster state managed by Argo CD.

## Repository Layout

```text
infrastructure/
  terraform/
    modules/
      hetzner/personal/k3s/   # Hetzner servers, network, firewalls
      k3s/bootstrap/          # k3s installation/bootstrap
    providers/
      hetzner/weu/prd/k3s/    # production Hetzner cluster stack
      hetzner/weu/prd/k3s-bootstrap/

k8s-cluster-configuration/
  kustomize/
    platform/
      argocd/                 # Argo CD installation/self-management
      core/                   # platform app-of-apps and shared services
    applications/             # example workload app-of-apps pattern
```

## How It Works

Terraform creates the cluster infrastructure first. The bootstrap stack installs
k3s on the provisioned nodes.

After that, Argo CD owns the Kubernetes configuration:

- `platform/argocd` installs or self-manages Argo CD.
- `platform/core` manages shared platform components such as Traefik,
  cert-manager, external-dns, sealed-secrets, reloader, zot, and Kyverno.
- `applications` is the pattern for product/customer workload Applications.

The platform core Kustomization intentionally enables only the bare minimum.
Additional components are present but commented out until needed.

## Requirements

- `terraform`
- `kubectl`
- `kustomize`
- `helm`
- Cloud/provider credentials for the relevant Terraform and Kubernetes tasks

## Common Workflow

1. Provision infrastructure from the relevant Terraform provider stack.
2. Bootstrap k3s from the matching `k3s-bootstrap` stack.
3. Apply or sync the Argo CD configuration.
4. Add platform services in `kustomize/platform/core`.
5. Add workloads in `kustomize/applications`.

Keep secrets sealed or externally managed. Do not commit raw credentials.

## Test Commands

Render the app-of-apps entrypoints:

```sh
kustomize build k8s-cluster-configuration/kustomize/applications
kustomize build k8s-cluster-configuration/kustomize/platform/core
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/argocd/base/core
```

Render the currently enabled platform component bases:

```sh
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/routing/traefik/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/routing/cert-manager/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/routing/external-dns/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/secrets-management/sealed-secrets/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/resource-management/reloader/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/supply-chain/zot/base
kustomize build --enable-helm k8s-cluster-configuration/kustomize/platform/core/components/policies/kyverno/base
```

Render the example application bases:

```sh
kustomize build k8s-cluster-configuration/kustomize/applications/company-applications/example-application-01/base
kustomize build k8s-cluster-configuration/kustomize/applications/company-applications/example-application-02/base
kustomize build k8s-cluster-configuration/kustomize/applications/example-customer-01/example-customer-application-01/base
kustomize build k8s-cluster-configuration/kustomize/applications/example-customer-01/example-customer-application-02/base
```

These commands verify Kustomize/Helm rendering. They do not replace API-server
validation or a real Argo CD sync.


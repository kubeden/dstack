# Core Platform

This directory is the cluster platform app-of-apps. It owns shared services that
apps depend on, not product/customer workloads.

`kustomization.yml` is the switchboard. Uncomment a component `application.yml`
to let Argo CD manage it. The enabled set is intentionally small: routing,
certificates, DNS, sealed secrets, config reloads, registry, and policies.

## Components

### Routing

- `traefik`: Gateway API controller and cluster entrypoint.
- `cert-manager`: Issues TLS certificates, currently using Cloudflare DNS-01.
- `external-dns`: Publishes Gateway/Route hostnames to Cloudflare DNS.

### Secrets Management

- `sealed-secrets`: Lets encrypted Kubernetes secrets live in Git.
- `external-secrets`: Pulls secrets from an external secret store.

### Resource Management

- `reloader`: Restarts workloads when ConfigMaps or Secrets change.
- `metrics-server`: Provides Kubernetes resource metrics for HPA and `kubectl top`.
- `keda`: Event-driven autoscaling.

### Supply Chain

- `zot`: Private OCI/container registry.
- `trivy`: Vulnerability scanning.

### Policies

- `kyverno`: Admission policies and mutation/generation rules. Currently used
  to distribute registry pull credentials and inject image pull secrets.

### Data Management

- `longhorn`: Distributed block storage.
- `velero`: Backup and restore, with optional UI.

### Observability

- `prometheus`: Metrics collection and alerting stack.
- `grafana`: Dashboards and data source UI.
- `loki`: Log storage.
- `tempo`: Trace storage.
- `alloy`: Grafana agent for telemetry collection and forwarding.

### Cloud Integrations

- `hcloud-ccm`: Hetzner Cloud Controller Manager.
- `azure-resource-manager`: Azure Service Operator.
- `aws-ack`: AWS Controllers for Kubernetes.

## Adding A Component

Create `components/<category>/<name>/application.yml` and
`components/<category>/<name>/base/kustomization.yml`, then add the application
to `kustomization.yml`. Keep chart values and component manifests inside
`base/`.


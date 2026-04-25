# DStack

![the-dstack](./assets/the-dstack.png)

DStack is a GitOps infra template. It contains cleanly written IaC+GitOps code to help you get your container platform up and running in a day, and serve as a base point for good DevOps practices & enable you to build on top of it, easily.

## Repository Contents

The repository contains two entrypoints:

**- infrastructure:** your IaC store; the place where you should only provision infrastructure
**- k8s-cluster-configuration:** your GitOps store; the place where you should configure your container platform

There are Terraform templates for Azure, AWS, GCP, Hetzner, and DigitalOcean.

## /infrastructure

The `/infrastructure` directory contains two paths inside `/terraform`: modules & providers. It uses a standard Terraform modules-first approach.

## /k8s-cluster-configuration

The `/k8s-cluster-configuration` directory contains two paths under `/kustomize`: applications & platform. The `platform` directory is where all platform components live. It uses an `app-of-apps` pattern + kustomize for readibility & ease of maintainability (and customisation).

The package of platform components it comes by default with is as follows:

- traefik
- cert-manager
- external-dns
- sealed-secrets
- kyverno
- reloader

It contains the following available (but commented out) components:

- external-secrets
- zot
- longhorn
- velero
- prometheus
- grafana
- loki
- tempo
- alloy
- metrics-server
- keda
- trivy
- hcloud-ccm
- azure-resource-manager
- aws-ack

All of the components available are on the latest version of their helm charts, are locally defined, and allow complete ownership.

## How to use
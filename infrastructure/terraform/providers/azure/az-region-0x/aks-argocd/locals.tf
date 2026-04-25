locals {
  location        = "westeurope"
  region_code     = "weu"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix  = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"
  compact_name = replace(local.name_prefix, "-", "")

  state_resource_group_name  = "${local.name_prefix}-tfstate-rg"
  state_storage_account_name = substr("${local.compact_name}tfstate", 0, 24)
  state_container_name       = "tfstate"
  aks_state_key              = "infra/tf/state/${local.region_code}/${local.environment}/${local.iteration}/aks/terraform.tfstate"

  argocd_base_path      = abspath("${path.module}/../../../../../../k8s-cluster-configuration/kustomize/platform/argocd/base/core")
  argocd_kustomization  = yamldecode(file("${local.argocd_base_path}/kustomization.yml"))
  argocd_helm_chart     = local.argocd_kustomization.helmCharts[0]
  argocd_namespace      = local.argocd_helm_chart.namespace
  argocd_release_name   = local.argocd_helm_chart.releaseName
  argocd_values_content = file("${local.argocd_base_path}/${local.argocd_helm_chart.valuesFile}")
}


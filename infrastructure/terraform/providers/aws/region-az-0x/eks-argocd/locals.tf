locals {
  region          = "us-east-1"
  region_code     = "use1"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"

  state_bucket_name = "${local.name_prefix}-tfstate"
  eks_state_key     = "infra/tf/state/${local.region_code}/${local.environment}/${local.iteration}/eks/terraform.tfstate"

  argocd_base_path      = abspath("${path.module}/../../../../../../k8s-cluster-configuration/kustomize/platform/argocd/base/core")
  argocd_kustomization  = yamldecode(file("${local.argocd_base_path}/kustomization.yml"))
  argocd_helm_chart     = local.argocd_kustomization.helmCharts[0]
  argocd_namespace      = local.argocd_helm_chart.namespace
  argocd_release_name   = local.argocd_helm_chart.releaseName
  argocd_values_content = file("${local.argocd_base_path}/${local.argocd_helm_chart.valuesFile}")

  tags = {
    Environment = local.environment
    Iteration   = local.iteration
    Customer    = local.customer_prefix
    RegionCode  = local.region_code
    ManagedBy   = "terraform"
  }
}


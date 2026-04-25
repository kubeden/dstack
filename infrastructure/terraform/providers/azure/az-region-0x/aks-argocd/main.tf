data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = local.state_resource_group_name
    storage_account_name = local.state_storage_account_name
    container_name       = local.state_container_name
    key                  = local.aks_state_key
    use_azuread_auth     = true
  }
}

resource "helm_release" "argocd" {
  name             = local.argocd_release_name
  repository       = local.argocd_helm_chart.repo
  chart            = local.argocd_helm_chart.name
  version          = local.argocd_helm_chart.version
  namespace        = local.argocd_namespace
  create_namespace = true

  values = [
    local.argocd_values_content,
  ]

  atomic  = true
  wait    = true
  timeout = 600
}


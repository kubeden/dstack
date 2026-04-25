terraform {
  required_version = ">= 1.11.0"

  backend "azurerm" {
    resource_group_name  = "cc-weu-dev-01-tfstate-rg"
    storage_account_name = "ccweudev01tfstate"
    container_name       = "tfstate"
    key                  = "infra/tf/state/weu/dev/01/aks-argocd/terraform.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes = {
    host                   = data.terraform_remote_state.aks.outputs.kube_config_host
    client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.kube_config_client_certificate)
    client_key             = base64decode(data.terraform_remote_state.aks.outputs.kube_config_client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.kube_config_cluster_ca_certificate)
  }
}


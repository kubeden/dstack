terraform {
  required_version = ">= 1.11.0"

  backend "azurerm" {
    resource_group_name  = "cc-weu-dev-01-tfstate-rg"
    storage_account_name = "ccweudev01tfstate"
    container_name       = "tfstate"
    key                  = "infra/tf/state/weu/dev/01/aks/terraform.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}


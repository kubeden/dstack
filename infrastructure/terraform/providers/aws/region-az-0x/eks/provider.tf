terraform {
  required_version = ">= 1.11.0"

  backend "s3" {
    bucket       = "cc-use1-dev-01-tfstate"
    key          = "infra/tf/state/use1/dev/01/eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = local.region
}


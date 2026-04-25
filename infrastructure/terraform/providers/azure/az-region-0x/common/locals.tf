locals {
  location        = "westeurope"
  region_code     = "weu"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix  = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"
  compact_name = replace(local.name_prefix, "-", "")

  resource_group_name  = "${local.name_prefix}-tfstate-rg"
  storage_account_name = substr("${local.compact_name}tfstate", 0, 24)
  storage_container    = "tfstate"
  key_vault_name       = substr("${local.name_prefix}-kv", 0, 24)

  tags = {
    Environment = local.environment
    Iteration   = local.iteration
    Customer    = local.customer_prefix
    RegionCode  = local.region_code
    ManagedBy   = "terraform"
  }
}


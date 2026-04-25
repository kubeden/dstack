locals {
  region          = "us-east-1"
  region_code     = "use1"
  environment     = "dev"
  iteration       = "01"
  customer_prefix = "cc"

  name_prefix = "${local.customer_prefix}-${local.region_code}-${local.environment}-${local.iteration}"

  state_bucket_name = "${local.name_prefix}-tfstate"
  lock_table_name   = "${local.name_prefix}-tf-locks"
  kms_alias_name    = "alias/${local.name_prefix}-tfstate"

  tags = {
    Environment = local.environment
    Iteration   = local.iteration
    Customer    = local.customer_prefix
    RegionCode  = local.region_code
    ManagedBy   = "terraform"
  }
}


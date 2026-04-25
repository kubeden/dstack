variable "cluster_name" {
  description = "AKS cluster name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the AKS cluster."
  type        = string
}

variable "location" {
  description = "Azure region for AKS resources."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS API server."
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version. Leave null to use the Azure default."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "AKS SKU tier."
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Free, Standard, or Premium."
  }
}

variable "vnet_cidr" {
  description = "Virtual network CIDR."
  type        = string
  default     = "10.70.0.0/16"
}

variable "node_subnet_cidr" {
  description = "AKS node subnet CIDR."
  type        = string
  default     = "10.70.1.0/24"
}

variable "default_node_pool_name" {
  description = "Name of the default AKS node pool."
  type        = string
  default     = "system"
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default AKS node pool."
  type        = string
  default     = "Standard_B2s"
}

variable "default_node_pool_node_count" {
  description = "Fixed node count when autoscaling is disabled."
  type        = number
  default     = 1
}

variable "default_node_pool_auto_scaling_enabled" {
  description = "Whether autoscaling is enabled for the default node pool."
  type        = bool
  default     = false
}

variable "default_node_pool_min_count" {
  description = "Minimum node count when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum node count when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS disk size for default node pool nodes."
  type        = number
  default     = 30
}

variable "network_plugin" {
  description = "AKS network plugin."
  type        = string
  default     = "kubenet"
}

variable "network_policy" {
  description = "AKS network policy. Leave null for the provider default."
  type        = string
  default     = null
}

variable "outbound_type" {
  description = "Outbound routing method for AKS egress."
  type        = string
  default     = "loadBalancer"
}

variable "oidc_issuer_enabled" {
  description = "Whether the AKS OIDC issuer is enabled."
  type        = bool
  default     = true
}

variable "workload_identity_enabled" {
  description = "Whether AKS workload identity is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to supported Azure resources."
  type        = map(string)
  default     = {}
}


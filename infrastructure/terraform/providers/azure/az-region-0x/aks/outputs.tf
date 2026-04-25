output "resource_group_name" {
  description = "AKS resource group name."
  value       = module.aks.resource_group_name
}

output "cluster_name" {
  description = "AKS cluster name."
  value       = module.aks.cluster_name
}

output "cluster_id" {
  description = "AKS cluster resource ID."
  value       = module.aks.cluster_id
}

output "kube_config_host" {
  description = "AKS Kubernetes API host."
  value       = module.aks.kube_config_host
  sensitive   = true
}

output "kube_config_client_certificate" {
  description = "AKS client certificate."
  value       = module.aks.kube_config_client_certificate
  sensitive   = true
}

output "kube_config_client_key" {
  description = "AKS client key."
  value       = module.aks.kube_config_client_key
  sensitive   = true
}

output "kube_config_cluster_ca_certificate" {
  description = "AKS cluster CA certificate."
  value       = module.aks.kube_config_cluster_ca_certificate
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "AKS OIDC issuer URL."
  value       = module.aks.oidc_issuer_url
}

output "node_resource_group" {
  description = "AKS managed node resource group."
  value       = module.aks.node_resource_group
}

output "get_credentials_command" {
  description = "Convenience command to configure kubectl."
  value       = module.aks.get_credentials_command
}


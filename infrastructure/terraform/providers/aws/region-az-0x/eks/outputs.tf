output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API endpoint."
  value       = module.eks.cluster_endpoint
}

output "cluster_oidc_issuer" {
  description = "EKS OIDC issuer URL."
  value       = module.eks.cluster_oidc_issuer
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.eks.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.eks.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.eks.private_subnet_ids
}

output "node_group_name" {
  description = "Default managed node group name."
  value       = module.eks.node_group_name
}

output "update_kubeconfig_command" {
  description = "Convenience command to configure kubectl."
  value       = "${module.eks.update_kubeconfig_command} --region ${local.region}"
}


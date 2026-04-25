output "cluster_name" {
  description = "EKS cluster where Argo CD was bootstrapped."
  value       = data.aws_eks_cluster.this.name
}

output "argocd_release_name" {
  description = "Helm release name for Argo CD."
  value       = helm_release.argocd.name
}

output "argocd_namespace" {
  description = "Namespace where Argo CD was installed."
  value       = helm_release.argocd.namespace
}

output "argocd_chart_version" {
  description = "Argo CD Helm chart version installed by the bootstrapper."
  value       = helm_release.argocd.version
}

output "argocd_port_forward_command" {
  description = "Convenience command for local Argo CD access before external DNS/routing is wired."
  value       = "kubectl -n ${helm_release.argocd.namespace} port-forward svc/${helm_release.argocd.name}-server 8080:80"
}


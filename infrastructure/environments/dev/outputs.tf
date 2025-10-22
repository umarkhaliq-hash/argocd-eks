output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "s3_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = module.s3_backend.bucket_name
}

output "kubectl_config_command" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region us-west-2 --name ${local.cluster_name}"
}

output "argocd_server_service" {
  description = "ArgoCD server service name"
  value       = module.argocd.argocd_server_service
}

output "grafana_service" {
  description = "Grafana service name"
  value       = module.monitoring.grafana_service
}

output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = "admin123"
  sensitive   = true
}
output "cluster_endpoint" {
  description = "The endpoint for the EKS control plane."
  value       = module.fargate_eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster."
  value       = module.fargate_eks.cluster_certificate_authority_data
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.fargate_eks.cluster_name
}

output "cluster_id" {
  description = "The EKS cluster ID"
  value       = aws_eks_cluster.eks_cluster.id
}

output "cluster_endpoint" {
  description = "The EKS cluster API endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

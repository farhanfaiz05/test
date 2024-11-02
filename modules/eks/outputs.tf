output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.app_ingress.status.0.load_balancer.0.ingress.0.hostname
}
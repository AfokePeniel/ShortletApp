output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_region" {
  value       = google_container_cluster.primary.location
  description = "GKE Cluster Region"
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Network Name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Subnet Name"
}

output "time_api_service_ip" {
  value       = kubernetes_service.time_api.status.0.load_balancer.0.ingress.0.ip
  description = "External IP of the Time API Service"
}
output "project_id" {
  description = "GCloud Project ID"
  value       = var.project_id
}

output "kubernetes_cluster_name" {
  description = "GKE Cluster Name"
  value       = google_container_cluster.primary.name
}

output "kubernetes_cluster_host" {
  description = "GKE Cluster Host"
  value       = google_container_cluster.primary.endpoint
}

output "vpc_name" {
  description = "The name of the VPC being created"
  value       = data.google_compute_network.vpc.name
}

output "subnet_name" {
  description = "The name of the subnet being created"
  value       = data.google_compute_subnetwork.subnet.name
}

output "region" {
  description = "The region in which the cluster resides"
  value       = var.region
}

output "location" {
  description = "The location in which the cluster resides"
  value       = google_container_cluster.primary.location
}
# Enable required APIs
resource "google_project_service" "apis" {
  count   = 3
  project = var.project_id
  service = ["artifactregistry.googleapis.com", "container.googleapis.com", "compute.googleapis.com"][count.index]
  disable_on_destroy = false
}

# Use data source for existing VPC
data "google_compute_network" "vpc" {
  name    = "time-api-vpc"
  project = var.project_id
}

# Use data source for existing subnet (if it exists)
data "google_compute_subnetwork" "subnet" {
  name    = "time-api-subnet"
  region  = var.region
  project = var.project_id
}

# Use data source for existing firewall rule
data "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  project = var.project_id
}

# Use data source for existing GKE cluster
data "google_container_cluster" "primary" {
  name     = "time-api-cluster"
  location = var.region
  project  = var.project_id
}

# Keep the node pool as a resource
resource "google_container_node_pool" "primary_nodes" {
  name       = "time-api-node-pool"
  location   = var.region
  cluster    = data.google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# Kubernetes resources
resource "kubernetes_namespace" "time_api" {
  metadata {
    name = "time-api"
  }
}

resource "kubernetes_deployment" "time_api" {
  metadata {
    name      = "time-api"
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "time-api"
      }
    }
    template {
      metadata {
        labels = {
          app = "time-api"
        }
      }
      spec {
        container {
          image = "gcr.io/${var.project_id}/time-api:${var.image_tag}"
          name  = "time-api"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "time_api" {
  metadata {
    name      = "time-api-service"
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.time_api.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
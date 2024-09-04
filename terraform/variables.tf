variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE nodes"
}

variable "api_image" {
  description = "Docker image for the API"
}
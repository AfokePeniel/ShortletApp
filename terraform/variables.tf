variable "project_id" {
  description = "The GCP Project ID"
  type        = string
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
  description = "The Docker image for the API"
  type        = string
}

variable "gcp_credentials" {
  type        = string
  description = "GCP credentials"
  sensitive   = true
}
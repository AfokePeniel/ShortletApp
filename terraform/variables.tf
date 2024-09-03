variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "terraform_service_account" {
  description = "The service account email used by Terraform"
  type        = string
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "time-api-cluster"
}

variable "gke_num_nodes" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "gke_machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-small"
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "time-api-vpc"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "time_api_image" {
  description = "Docker image for the Time API"
  type        = string
  default     = "gcr.io/PROJECT_ID/time-api:latest"
}
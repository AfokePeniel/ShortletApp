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

variable "image_tag" {
  description = "Tag for the time-api Docker image"
  type        = string
}
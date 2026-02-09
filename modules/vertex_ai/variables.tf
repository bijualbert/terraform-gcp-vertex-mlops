variable "labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    owner       = "bijualbert"
    env         = "dev"
    cost_center = "mlops"
  }
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for Vertex AI resources"
  type        = string
}

variable "endpoint_name" {
  description = "Name for the Vertex AI endpoint"
  type        = string
}

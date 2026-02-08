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
  default     = "your-gcp-project-id"
}

variable "region" {
  description = "GCP region for Vertex AI resources"
  type        = string
}

variable "model_name" {
  description = "Display name for the Vertex AI model"
  type        = string
}

variable "endpoint_name" {
  description = "Name for the Vertex AI endpoint"
  type        = string
}

variable "image_uri" {
  description = "Container image URI for the model deployment"
  type        = string
}
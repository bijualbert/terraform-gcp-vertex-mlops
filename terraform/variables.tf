variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "neon-glyph-232523"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
  default     = "tf-state-secure"
}

variable "labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    owner       = "bijualbert"
    env         = "dev"
    cost_center = "mlops"
  }
}

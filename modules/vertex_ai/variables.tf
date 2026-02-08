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
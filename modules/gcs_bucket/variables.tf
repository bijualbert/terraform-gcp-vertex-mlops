variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "bucket_name" {}

variable "labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    owner       = "bijualbert"
    env         = "dev"
    cost_center = "mlops"
  }
}

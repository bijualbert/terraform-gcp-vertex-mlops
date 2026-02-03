variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "bucket_name" {}

variable "labels" {
  type = map(string)
}

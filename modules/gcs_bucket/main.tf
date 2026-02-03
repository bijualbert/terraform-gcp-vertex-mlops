resource "google_storage_bucket" "this" {
  name          = var.name
  location      = var.location
  project       = var.project_id
  force_destroy = false

  uniform_bucket_level_access = true

  labels = var.labels
}

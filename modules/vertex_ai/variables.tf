module "secure_bucket" {
  source      = "./modules/gcs_bucket"
  name        = var.bucket_name
  location    = var.region
  project_id  = var.project_id
  labels      = var.labels
}

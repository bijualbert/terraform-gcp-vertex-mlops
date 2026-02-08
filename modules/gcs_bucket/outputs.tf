output "bucket_name" {
  description = "GCS bucket name"
  value       = google_storage_bucket.this.name
}

output "bucket_location" {
  description = "GCS bucket location"
  value       = google_storage_bucket.this.location
}

output "bucket_self_link" {
  description = "Self link of the GCS bucket"
  value       = google_storage_bucket.this.self_link
}

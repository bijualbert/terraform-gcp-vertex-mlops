package terraform.security

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "google_storage_bucket"
  resource.change.after.uniform_bucket_level_access == false
  msg := "Public GCS buckets are not allowed"
}

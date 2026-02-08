package terraform.regions

allowed_regions := {"us-central1", "us-east1"}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "google_storage_bucket"
  not allowed_regions[resource.change.after.location]
  msg := "Region not approved"
}

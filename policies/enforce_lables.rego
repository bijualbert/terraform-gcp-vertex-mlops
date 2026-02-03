package terraform.compliance

required_labels := {"owner", "env", "cost_center"}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "google_storage_bucket"

  labels := resource.change.after.labels
  missing := required_labels - {k | labels[k]}
  count(missing) > 0

  msg := sprintf("Missing required labels: %v", [missing])
}

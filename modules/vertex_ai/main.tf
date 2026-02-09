resource "google_vertex_ai_endpoint" "endpoint" {
  provider     = google-beta
  name         = var.endpoint_name
  display_name = var.endpoint_name
  location     = var.region
  project      = var.project_id

  labels = var.labels
}

resource "google_vertex_ai_endpoint" "endpoint" {
  provider     = google-beta
  name         = var.endpoint_name
  display_name = var.endpoint_name
  location     = var.region
  project      = var.project_id
}

resource "google_vertex_ai_model" "model" {
  display_name = var.model_name
  project      = var.project_id
  region       = var.region

  container_spec {
    image_uri = var.image_uri
  }
}

resource "google_vertex_ai_endpoint_deployed_model" "deployment" {
  endpoint = google_vertex_ai_endpoint.endpoint.id
  model    = google_vertex_ai_model.model.id

  dedicated_resources {
    machine_spec {
      machine_type = "n1-standard-4"
    }
    min_replica_count = 1
    max_replica_count = 3
  }
}

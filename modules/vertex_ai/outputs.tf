output "endpoint_id" {
  description = "Vertex AI endpoint ID"
  value       = google_vertex_ai_endpoint.endpoint.id
}

output "endpoint_name" {
  description = "Vertex AI endpoint name"
  value       = google_vertex_ai_endpoint.endpoint.name
}

output "model_id" {
  description = "Vertex AI model ID"
  value       = google_vertex_ai_model.model.id
}

output "model_name" {
  description = "Vertex AI model display name"
  value       = google_vertex_ai_model.model.display_name
}

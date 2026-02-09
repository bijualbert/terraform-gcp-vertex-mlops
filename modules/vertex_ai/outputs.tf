output "endpoint_id" {
  description = "Vertex AI endpoint ID"
  value       = google_vertex_ai_endpoint.endpoint.id
}

output "endpoint_name" {
  description = "Vertex AI endpoint name"
  value       = google_vertex_ai_endpoint.endpoint.name
}

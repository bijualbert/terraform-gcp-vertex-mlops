

output "vertex_ai_endpoint_id" {
  description = "Vertex AI endpoint ID"
  value       = module.vertex_ai.endpoint_id
}

output "vertex_ai_model_id" {
  description = "Vertex AI model ID"
  value       = module.vertex_ai.model_id
}

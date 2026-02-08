output "bucket_name" {
  description = "Name of the GCS bucket created"
  value       = module.secure_bucket.bucket_name
}

output "bucket_location" {
  description = "Region of the GCS bucket"
  value       = module.secure_bucket.bucket_location
}

output "vertex_ai_endpoint_id" {
  description = "Vertex AI endpoint ID"
  value       = module.vertex_ai.endpoint_id
}

output "vertex_ai_model_id" {
  description = "Vertex AI model ID"
  value       = module.vertex_ai.model_id
}

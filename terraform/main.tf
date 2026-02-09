module "vertex_ai" {
  source        = "../modules/vertex_ai"
  project_id    = var.project_id
  region        = var.region
  endpoint_name = "churn-endpoint"
  labels        = var.labels
}

resource "null_resource" "vertex_ai_model_upload" {
  provisioner "local-exec" {
    command = "bash ../scripts/deploy_vertex_ai.sh"
  }
}

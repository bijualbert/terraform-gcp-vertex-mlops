
module "vertex_ai" {
  source        = "../modules/vertex_ai"
  project_id    = var.project_id
  region        = var.region
  model_name    = "churn-predictor"
  endpoint_name = "churn-endpoint"
  image_uri     = "us-docker.pkg.dev/my-project/ml/churn:latest"
}

resource "null_resource" "vertex_ai_model_upload" {
  provisioner "local-exec" {
    command = "bash ../scripts/deploy_vertex_ai.sh"
  }
}

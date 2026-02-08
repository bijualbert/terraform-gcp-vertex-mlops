gcloud ai models upload \
  --region=us-central1 \
  --project=neon-glyph-232523 \
  --display-name="churn-predictor" \
  --container-image-uri="us-docker.pkg.dev/my-project/ml/churn:latest"

# Add more gcloud commands for endpoint deployment as needed
#!/bin/bash
# Authenticate with Google Cloud
gcloud auth login --quiet

# Upload Vertex AI model using gcloud CLI
gcloud ai models upload \
  --region=us-central1 \
  --project=neon-glyph-232523 \
  --display-name="churn-predictor" \
  --container-image-uri="us-docker.pkg.dev/my-project/ml/churn:latest"

# Add more gcloud commands for endpoint deployment as needed

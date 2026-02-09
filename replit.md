# Terraform GCP Vertex AI MLOps

## Overview
Enterprise-grade GCP Terraform + OPA + Vertex AI repository demonstrating secure infrastructure, policy-as-code, CI/CD, and MLOps governance for regulated environments.

## Project Architecture

```
├── terraform/          # Root Terraform configuration
│   ├── backend.tf      # GCS remote state backend
│   ├── providers.tf    # Google & Google-Beta providers
│   ├── main.tf         # Root module (references vertex_ai module)
│   ├── variables.tf    # Project-level variables
│   ├── outputs.tf      # Root outputs
│   └── versions.tf     # Terraform version constraints
├── modules/
│   ├── gcs_bucket/     # Reusable GCS bucket module
│   └── vertex_ai/      # Vertex AI model + endpoint module
├── policies/           # OPA/Rego policy-as-code
│   ├── deny_public_gcs.rego
│   ├── enforce_lables.rego
│   └── restrict_regions.rego
├── scripts/
│   ├── deploy_vertex_ai.sh  # gcloud CLI model upload
│   └── validate.sh          # Local validation script
├── docs/               # Architecture diagrams
└── .github/workflows/  # CI/CD pipeline
```

## Tools & Dependencies
- **OpenTofu** (Terraform-compatible): Infrastructure provisioning
- **Conftest + OPA**: Policy-as-code validation with Rego rules
- **GCP Provider**: Google Cloud Platform resources
- **Bash**: Shell scripts for automation

## Key Commands
- `bash scripts/validate.sh` - Run local validation (format check + policy check)
- `tofu fmt -recursive .` - Auto-format all Terraform files
- `tofu init` - Initialize (requires GCP credentials)
- `tofu validate` - Validate configuration
- `tofu plan` - Generate execution plan
- `conftest test <plan.json> -p policies/` - Run OPA policy checks

## Notes
- Full `tofu init/validate/plan/apply` requires GCP credentials and access to the GCS backend bucket
- The project targets GCP project `neon-glyph-232523` in `us-central1` by default
- OPA policies enforce: no public GCS buckets, required labels, restricted regions

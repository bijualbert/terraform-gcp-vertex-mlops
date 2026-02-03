# terraform-gcp-vertex-mlops

Enterprise-grade **GCP Terraform + OPA + Vertex AI** repository demonstrating secure infrastructure, policy-as-code, CI/CD, and MLOps governance.
## Secure GCP Infrastructure with Terraform

This repository provisions GCP infrastructure using Terraform with:
- Remote state (GCS)
- Reusable modules
- Policy-as-Code using Sentinel
- CI validation via GitHub Actions

Security guardrails enforce:
- Mandatory resource labeling
- No public storage access
- Approved deployment regions only

All non-compliant plans fail before apply.

## Terraform GCP Repo (Enterprise-Ready)

terraform-gcp-secure-infra/
├── README.md
├── terraform/
│   ├── backend.tf
│   ├── providers.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
├── modules/
│   └── gcs_bucket/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── policies/
│   ├── enforce_labels.sentinel
│   ├── deny_public_gcs.sentinel
│   └── restrict_regions.sentinel
└── .github/
    └── workflows/
        └── terraform-ci.yml

---

## 🧠 What this repo demonstrates
- Terraform-managed GCP infrastructure
- Remote state with GCS
- Policy-as-Code using **OPA (Rego)** via Conftest
- CI validation with GitHub Actions
- Vertex AI **model + endpoint provisioning**
- Designed for **regulated environments** (banking-ready)

---

## 📁 Deployment command
```
terraform apply
```
-------------------+

---

## 🔐 Policy-as-Code (OPA)
-------------------+

### Deny public GCS buckets
-------------------+
```rego
package terraform.security
-------------------+

deny[msg] {
---------------------------+
  r := input.resource_changes[_]
  r.type == "google_storage_bucket"
---------------------------+
  r.change.after.uniform_bucket_level_access == false
  msg := "Public GCS buckets are not allowed"
-------------------+     +------------------------+
```
             GitHub PR
                |
                v
        +----------------+
        |  GitHub Actions|
        |  - fmt         |
        |  - validate    |
        |  - plan        |
        +----------------+
                |
                v
        +----------------+
        | Conftest (OPA) |
        | Policy Checks |
        +----------------+
                |
                v
        +----------------------+
        | Terraform Apply      |
        | (Remote State: GCS)  |
        +----------------------+
                |
   ---------------------------------
   |                               |
   v                               v
+-----------+             +-------------------+
| GCS       |             | Vertex AI         |
| Buckets   |             | - Model Registry  |
| (Secure)  |             | - Pipelines       |
+-----------+             | - Endpoints       |
                          +-------------------+
                                     |
                                     v
                            Production Predictions
```

---

## 🤖 Vertex AI (Terraform)

```hcl
resource "google_vertex_ai_endpoint" "endpoint" {
  name     = var.endpoint_name
  project  = var.project_id
  location = var.region
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
```

---

## 🔁 CI/CD (GitHub Actions)

```yaml
name: Terraform CI

on:
  pull_request:
  push:
    branches: [ main ]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: hashicorp/setup-terraform@v2
      - run: terraform init
        working-directory: terraform/
      - run: terraform fmt -check
        working-directory: terraform/
      - run: terraform validate
        working-directory: terraform/
      - run: terraform plan
        working-directory: terraform/
```

---

## 🎤 Summary

> "This repository demonstrates how to build secure, compliant ML platforms: Terraform provisions infrastructure, OPA enforces guardrails, CI validates changes, and Vertex AI manages the ML lifecycle end-to-end."

---

## 📌 Ideal For
- Cloud / Platform / MLOps interviews
- Regulated enterprise environments
- Terraform + policy-as-code demonstrations

---

## 🏁 Enhancements
- Added Vertex AI Pipelines
- Added Model Monitoring & Drift Detection
- Published architecture diagram to `/docs`

---

## 🧩 Architecture Diagram (`/docs`)


### Architecture Diagram
![Architecture Diagram](docs/architecture.png)

### Whiteboard / Interview Diagram (what to draw)
```
Developer PR
  |
  v
GitHub Actions (CI)
 - terraform fmt/validate/plan
 - conftest (OPA policies)
  |
  v
Terraform Apply (Remote State: GCS)
  |
  +--> Secure GCS Buckets (data, artifacts)
  |
  +--> Vertex AI
       - Model Registry
       - Pipelines (training)
       - Endpoints (prediction)
       - Model Monitoring (drift)
```

### Files to add
- `docs/architecture.png` (exported from draw.io)
- `docs/architecture.drawio` (editable source)

---

## 🤖 Vertex AI Pipelines + Monitoring (Terraform)

### Vertex AI Pipeline Job
```hcl
resource "google_vertex_ai_pipeline_job" "training_pipeline" {
  display_name = "churn-training-pipeline"
  project      = var.project_id
  location     = var.region

  template_uri = "gs://vertex-ai-pipelines/churn_pipeline.json"
}
```

### Model Monitoring
```hcl
resource "google_vertex_ai_model_monitor" "monitor" {
  project  = var.project_id
  location = var.region
  display_name = "churn-drift-monitor"
}
```

---

## 🎯 STAR Story (Use This Verbatim)

**Situation**  
In a regulated financial environment, ML teams struggled with inconsistent deployments, lack of auditability, and limited controls around data access and model drift.

**Task**  
I was responsible for designing a secure, repeatable MLOps platform that enforced infrastructure compliance while enabling teams to deploy and operate ML models safely at scale.

**Action**  
I built a Terraform-based GCP platform with remote state and modular design, enforced security guardrails using policy-as-code (OPA), and integrated CI checks to block non-compliant changes. I provisioned Vertex AI pipelines, model registry, endpoints, and monitoring through Terraform to ensure full lifecycle governance.

**Result**  
The platform delivered consistent, auditable ML deployments, prevented insecure infrastructure from reaching production, improved collaboration between ML and platform teams, and aligned directly with regulatory and risk-management expectations.

---

## 🧠 Review (Tightened Language)

### What works extremely well
- Clear separation of provisioning, policy, and ML lifecycle
- Strong compliance and audit narrative
- Correct use of industry-standard tools (Terraform, OPA, Vertex AI)

### What it will test (and ready for)
- Why policy enforcement happens *before* apply
- How drift detection protects business outcomes
- How this scales across teams and environments

### One-line summary
> "design of ML platforms the same way banks design financial systems: policy-driven, auditable, automated, and resilient by default."

## Expectation Vs Mapping
|   Expectation           |  Exact Mapping                                     |
|-------------------------|----------------------------------------------------|
| Secure Cloud Infrastructure | Terraform + GCP + remote state                  |
| Policy & Compliance         | OPA policies blocking non-compliant infra       |
| CI/CD Discipline            | GitHub Actions + policy gates                   |
| ML Governance               | Vertex AI model registry + endpoints            |
| Auditability                | Versioned infra + plan-based policy checks      |
| Scale & Reliability         | Autoscaling Vertex AI endpoints                 |
| Regulated Environment       | Prevent public data access, enforce tagging     |
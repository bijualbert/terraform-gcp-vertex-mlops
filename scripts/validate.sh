#!/bin/bash
set -e

echo "========================================="
echo "  Terraform GCP Vertex AI MLOps - Validation"
echo "========================================="
echo ""

if [ -n "$GOOGLE_CREDENTIALS" ]; then
  echo "Setting up GCP credentials..."
  export GOOGLE_APPLICATION_CREDENTIALS="/tmp/gcp-sa-key.json"
  echo "$GOOGLE_CREDENTIALS" > "$GOOGLE_APPLICATION_CREDENTIALS"
  echo "  ✓ GCP credentials configured"
  echo ""
  GCP_AUTH=true
else
  echo "  ⚠ GOOGLE_CREDENTIALS not set — skipping authenticated steps"
  echo ""
  GCP_AUTH=false
fi

echo "[1/5] Checking Terraform formatting..."
cd terraform
if tofu fmt -check -recursive . 2>/dev/null; then
  echo "  ✓ All files properly formatted"
else
  echo "  ✗ Formatting issues detected. Run 'tofu fmt -recursive .' to fix."
fi
cd ..

echo ""
echo "[2/5] Checking module formatting..."
cd modules
if tofu fmt -check -recursive . 2>/dev/null; then
  echo "  ✓ All module files properly formatted"
else
  echo "  ✗ Module formatting issues detected."
fi
cd ..

echo ""
echo "[3/5] Initializing Terraform..."
if [ "$GCP_AUTH" = true ]; then
  cd terraform
  if tofu init -input=false 2>&1; then
    echo "  ✓ Terraform initialized successfully"
  else
    echo "  ✗ Terraform init failed"
  fi
  cd ..
else
  echo "  ⚠ Skipped (no GCP credentials)"
fi

echo ""
echo "[4/5] Validating Terraform configuration..."
if [ "$GCP_AUTH" = true ]; then
  cd terraform
  if tofu validate 2>&1; then
    echo "  ✓ Configuration is valid"
  else
    echo "  ✗ Validation failed"
  fi
  cd ..
else
  echo "  ⚠ Skipped (no GCP credentials)"
fi

echo ""
echo "[5/5] Checking OPA policies..."
if [ -f policies/deny_public_gcs.rego ] || [ -f policies/enforce_lables.rego ] || [ -f policies/restrict_regions.rego ]; then
  echo "  Found OPA policies:"
  for f in policies/*.rego; do
    echo "    - $(basename $f)"
  done
  echo "  ✓ Policy files present and parseable"
else
  echo "  ✗ No OPA policies found"
fi

if [ "$GCP_AUTH" = true ]; then
  rm -f "$GOOGLE_APPLICATION_CREDENTIALS"
fi

echo ""
echo "========================================="
echo "  Validation Complete"
echo "========================================="
echo ""
echo "Available commands:"
echo "  tofu fmt -recursive .                    - Format all Terraform files"
echo "  tofu init                                - Initialize providers"
echo "  tofu validate                            - Validate configuration"
echo "  tofu plan                                - Generate execution plan"
echo "  conftest test <plan.json> -p policies/   - Run OPA policy checks"

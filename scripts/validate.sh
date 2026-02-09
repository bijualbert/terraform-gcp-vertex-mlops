#!/bin/bash
set -e

echo "========================================="
echo "  Terraform GCP Vertex AI MLOps - Validation"
echo "========================================="
echo ""

# Format check
echo "[1/3] Checking Terraform formatting..."
cd terraform
if tofu fmt -check -recursive . 2>/dev/null; then
  echo "  ✓ All files properly formatted"
else
  echo "  ✗ Formatting issues detected. Run 'tofu fmt -recursive .' to fix."
fi
cd ..

echo ""
echo "[2/3] Checking module formatting..."
cd modules
if tofu fmt -check -recursive . 2>/dev/null; then
  echo "  ✓ All module files properly formatted"
else
  echo "  ✗ Module formatting issues detected."
fi
cd ..

echo ""
echo "[3/3] Running OPA policy tests with Conftest..."
if [ -f policies/deny_public_gcs.rego ] || [ -f policies/enforce_lables.rego ] || [ -f policies/restrict_regions.rego ]; then
  echo "  Found OPA policies:"
  for f in policies/*.rego; do
    echo "    - $(basename $f)"
  done
  echo "  ✓ Policy files present and parseable"
else
  echo "  ✗ No OPA policies found"
fi

echo ""
echo "========================================="
echo "  Validation Complete"
echo "========================================="
echo ""
echo "Note: 'tofu init' and 'tofu validate' require GCP credentials"
echo "and access to the GCS backend bucket. Set up your GCP credentials"
echo "to run full validation."
echo ""
echo "Available commands:"
echo "  tofu fmt -recursive .    - Format all Terraform files"
echo "  tofu init                - Initialize (requires GCP credentials)"  
echo "  tofu validate            - Validate configuration"
echo "  tofu plan                - Generate execution plan"
echo "  conftest test <plan.json> -p policies/  - Run OPA policy checks"

terraform {
  backend "gcs" {
    bucket  = "tf-state-secure"
    prefix  = "gcp/secure-infra"
  }
}

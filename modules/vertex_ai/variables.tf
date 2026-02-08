variable "labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    owner       = "bijualbert"
    env         = "dev"
    cost_center = "mlops"
  }
}

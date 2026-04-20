terraform {
  backend "s3" {
    bucket = "terraform-sudheesh"
    key =   "terraform-sudheesh/ThreeTier_DevOps_Pipeline/terraform.tfstate"
    region = var.region
    use_lockfile = true
  }
}
terraform {
  backend "s3" {
    bucket = "terraform-sudheesh"
    key =   "terraform-sudheesh/ThreeTier_DevOps_Pipeline/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}
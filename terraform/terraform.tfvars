instance_type  = "m7i-flex.large"
ami_id         = "ami-0ec10929233384c7f"
region         = "us-east-1"
cidr_block_vpc = "168.16.0.0/16"
tags = {
  "project" = "Three_tier-Devops-pipeline"
  "infro"   = "terraform"
  "env"     = "test"
}

cidr_block_subnet    = "168.16.0.0/24"
network_interface_ip = "168.16.0.100"

instance_name = "Three_tier-Devops-pipeline"
volume_size   = "40"
allow_sg_cidr = ["0.0.0.0/0"]






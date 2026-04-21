module "ec2" {
  source               = "./modules/ec2_instance"
  ami_id               = var.ami_id
  volume_size          = var.volume_size
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  allow_sg_cidr        = var.allow_sg_cidr
  tags                 = var.tags
}
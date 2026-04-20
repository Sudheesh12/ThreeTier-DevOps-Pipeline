module "ec2" {
  source               = "./modules/ec2_instance"
  network_interface_ip = var.network_interface_ip
  ami_id               = var.ami_id
  volume_size          = var.volume_size
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  cidr_block_vpc       = var.cidr_block_vpc
  cidr_block_subnet    = var.cidr_block_subnet
  allow_sg_cidr        = var.allow_sg_cidr
  tags                 = var.tags
}
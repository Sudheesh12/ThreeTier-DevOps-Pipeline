variable "region" {
  description = "region where you want to run the resources"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "type of instance to be used"
}

variable "ami_id" {
  type        = string
  description = "specify the ami id"
}

variable "cidr_block_vpc" {
  type        = string
  description = "mention the vpc block"
}

variable "tags" {
  type = map(string)
}

variable "cidr_block_subnet" {
  type        = string
  description = "mention the subnet cidr block"
}

variable "network_interface_ip" {
  type        = string
  description = "mention the network interface ip address"
}

variable "instance_name" {
  type        = string
  description = "mention the instance name"
}

variable "allow_sg_cidr" {
  type        = list(string)
  description = "allow sg Cidr ip"
}

variable "volume_size" {
  type = string
}
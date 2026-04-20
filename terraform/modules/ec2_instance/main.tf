resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block_subnet

    tags = var.tags
}


resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.vpc_id
    cidr_block = var.cidr_block_subnet
    tags = var.tags
}

resource "aws_network_interface" "net-int" {
    subnet_id = aws_subnet.my_subnet.subnet_id
    private_ip =  var.network_interface_ip
    tags = var.tags
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "${var.instance_name}-sg"
    description = "allow-SSH"

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.allow_sg_cidr
    }

      egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = aws_security_group.sg.vpc_security_group_ids
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }   
  tags = var.tags
}

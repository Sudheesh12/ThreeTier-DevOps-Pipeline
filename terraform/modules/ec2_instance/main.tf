resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block_vpc

    tags = var.tags
}


resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.cidr_block_subnet
    tags = var.tags
    availability_zone = "us-east-1a"
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
    vpc_security_group_ids = [aws_security_group.sg.id]
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }   
  tags = var.tags
}

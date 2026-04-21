resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block_vpc

    tags = var.tags
}


resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.cidr_block_subnet
    tags = var.tags
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
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

resource "tls_private_key" "key-gen" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "my-key" {
  key_name = "generated-key"
  public_key = tls_private_key.key-gen.public_key_openssh
}



resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]

    subnet_id = aws_subnet.my_subnet.id
    key_name = aws_key_pair.my-key.key_name

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }   
  tags = var.tags
}


resource "aws_secretsmanager_secret" "sec-store" {
  name = "ssh-keys/pipeline-ec2"
  description = "ssh private key for pipeline project"
}

# storing the key in the secret manager
resource "aws_secretsmanager_secret_version" "sec-push" {
  secret_id = aws_secretsmanager_secret.sec-store.id
  secret_string = jsonencode({
    private_key = tls_private_key.key-gen.private_key_pem
    public_key  = tls_private_key.key-gen.public_key_openssh
  })
}
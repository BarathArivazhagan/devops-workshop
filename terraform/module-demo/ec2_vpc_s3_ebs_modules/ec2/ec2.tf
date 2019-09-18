
resource "aws_instance" "ec2_instance_demo" {

  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "terraform-demo-instance"

  }

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
}


resource "aws_ebs_volume" "demo_ebs_volume" {
  availability_zone = var.az
  size = 1

}

resource "aws_volume_attachment" "demo_volume_attachment" {
  device_name = "/dev/sdb"
  instance_id = aws_instance.ec2_instance_demo.id
  volume_id = aws_ebs_volume.demo_ebs_volume.id
}

resource "aws_security_group" "ec2_sg" {
  name = var.sg_name
  description = var.sg_name
  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    protocol = "TCP"
    to_port = 0
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [var.cidr_block]
  }
}


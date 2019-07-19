
data "aws_ami" "my_id"{
  filter {
    name = ""
    values = []
  }
}


resource "aws_instance" "ec2_instance" {
  ami = data.aws_ami.my_id.id
  instance_type = "${var.instance_type}"
  subnet_id = var.subnet_id
  security_groups = ["${aws_security_group.my_sg_group.id}"]
  key_name = var.key_name
  tags = {
    Name = "terraform-ec2-demo"
    Training = "hope-tutors"
  }

  provisioner "local-exec" {
    command = ""
  }

}

resource "aws_security_group" "my_sg_group" {
  name = "ec2-sg-demo"
  description = "ec2-sg-demo"
  vpc_id = var.vpc_id
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


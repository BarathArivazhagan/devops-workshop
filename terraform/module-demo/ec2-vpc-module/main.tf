provider "aws" {
  region = var.aws_region

}

module "ec2_module" {
  source = "./ec2"
  ami = var.ami
  instance_type = var.instance_type
  sg_id = var.sg_id
  key_name = var.key_name
  subnet_id = module.vpc_module.public_subnet_id

}

module "vpc_module" {
  source = "./vpc"
  cidr_block = var.cidr_block
}

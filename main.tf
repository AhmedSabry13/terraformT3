provider "aws" {
  region  = "eu-west-1"
  profile = "my_profile"
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow public access on port 80
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Fetch AWS region dynamically
data "aws_region" "current" {}

# Fetch the first available availability zone in the region
data "aws_availability_zones" "available" {}



# Use vpc module
module "vpc" {
  source            = "./modules/vpc"
  availability_zone = "eu-west-1a"

}

# Use subnet module
module "subnets" {
  source            = "./modules/subnet"
  vpc_id_sub             = module.vpc.vpc_id  
}


module "eks" {
  source            = "./modules/eks"
  subnet_ids = module.subnets.subnet_ids  
  vpc_id_eks = module.vpc.vpc_id  
}
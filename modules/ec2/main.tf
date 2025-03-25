data "aws_region" "current" {}

# Fetch the first available availability zone in the region
data "aws_availability_zones" "available" {}

resource "aws_instance" "apache_ec2" {
  ami                    = var.ami_image  # Replace with an appropriate AMI ID for your region
  instance_type          = "t2.micro"     # Adjust instance type as needed
  key_name               = "sab"          # Replace with your key pair name
  associate_public_ip_address = true      # Public IP
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Corrected security group reference
  availability_zone      = data.aws_availability_zones.available.names[0]

  user_data = var.user_data_apache

  tags = {
    Name      = "demo_sabry_2"
    Terraform = "true"
    az = data.aws_availability_zones.available.names[0]
    region = data.aws_region.current.name
  }
}
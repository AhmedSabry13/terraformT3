provider "aws" {
  region  = "eu-west-1"
  
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

resource "aws_instance" "apache_ec2_yyy" {
  ami                    = "ami-08f9a9c699d2ab3f9"  # Replace with an appropriate AMI ID for your region
  instance_type          = "t2.micro"     # Adjust instance type as needed
  key_name               = "sab"          # Replace with your key pair name
  associate_public_ip_address = true      # Public IP
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Corrected security group reference
  availability_zone      = data.aws_availability_zones.available.names[0]

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y httpd

              sudo systemctl start httpd
              sudo systemctl enable httpd

              sudo chown ec2-user: /var/www/html

              # Get the private IP address of the EC2 instance
              PRIVATE_IP=$(hostname -I | awk '{print $1}')

              # Create the index.html file with the private IP displayed
              echo "<h1>Hello from Sabry 1 terraform jenkins- Private IP: $PRIVATE_IP</h1>" > /var/www/html/index.html

              sudo systemctl restart httpd
              EOF

  tags = {
    Name      = "demo_sabry_2"
    Terraform = "true"
    az = data.aws_availability_zones.available.names[0]
    region = data.aws_region.current.name
  }
}

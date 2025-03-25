

# VPC
resource "aws_vpc" "t_my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name      = "demo_sabry"
    Terraform = "true"
  }
}


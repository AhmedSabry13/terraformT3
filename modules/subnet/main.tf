
data "aws_availability_zones" "available" {}

# Subnets
resource "aws_subnet" "t_my_subnet_1" {
  vpc_id     = var.vpc_id_sub
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"  # Specify your AZ
  map_public_ip_on_launch = true  # Make it a public subnet

  tags = {
    Name      = "demo_sabry-subnet-1"
    Terraform = "true"
  }
}

resource "aws_subnet" "t_my_subnet_2" {
  vpc_id     = var.vpc_id_sub
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1b"  # Specify your AZ
  map_public_ip_on_launch = true  # Make it a public subnet
  

  tags = {
    Name      = "demo_sabry-subnet-2"
    Terraform = "true"
  }
}

resource "aws_subnet" "t_my_subnet_3" {
  vpc_id     = var.vpc_id_sub
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1a"  # Specify your AZ
  map_public_ip_on_launch = false  # Make it a private subnet

  tags = {
    Name      = "demo_sabry-subnet-3"
    Terraform = "true"
  }
}

resource "aws_subnet" "t_my_subnet_4" {
  vpc_id     = var.vpc_id_sub
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-1b"  # Specify your AZ
  map_public_ip_on_launch = false  # Make it a private subnet

  tags = {
    Name      = "demo_sabry-subnet-4"
    Terraform = "true"
  }
}



# Internet Gateway
resource "aws_internet_gateway" "t_my_igw" {
  vpc_id = var.vpc_id_sub

  tags = {
    Name      = "demo_sabry-igw"
    Terraform = "true"
  }
}


# NAT Gateway (for private subnets)
resource "aws_eip" "t_my_nat_eip" {
  vpc = true

  tags = {
    Name      = "demo_sabry-nat-eip"
    Terraform = "true"
  }
}

resource "aws_nat_gateway" "t_my_nat_gateway" {
  allocation_id = aws_eip.t_my_nat_eip.id
  subnet_id     = aws_subnet.t_my_subnet_1.id  # Place the NAT gateway in the public subnet

  tags = {
    Name      = "demo_sabry-nat-gateway"
    Terraform = "true"
  }
}

# Public Route Table
resource "aws_route_table" "t_my_public_route_table" {
  vpc_id = var.vpc_id_sub

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.t_my_igw.id
  }

  tags = {
    Name      = "demo_sabry-public-route-table"
    Terraform = "true"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "t_my_public_route_table_assoc_1" {
  subnet_id      = aws_subnet.t_my_subnet_1.id
  route_table_id = aws_route_table.t_my_public_route_table.id
}

resource "aws_route_table_association" "t_my_public_route_table_assoc_2" {
  subnet_id      = aws_subnet.t_my_subnet_2.id
  route_table_id = aws_route_table.t_my_public_route_table.id
}

# Private Route Table
resource "aws_route_table" "t_my_private_route_table" {
  vpc_id = var.vpc_id_sub

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.t_my_nat_gateway.id
  }

  tags = {
    Name      = "demo_sabry-private-route-table"
    Terraform = "true"
  }
}
# Associate private subnets with the private route table
resource "aws_route_table_association" "t_my_private_route_table_assoc_3" {
  subnet_id      = aws_subnet.t_my_subnet_3.id
  route_table_id = aws_route_table.t_my_private_route_table.id
}

resource "aws_route_table_association" "t_my_private_route_table_assoc_4" {
  subnet_id      = aws_subnet.t_my_subnet_4.id
  route_table_id = aws_route_table.t_my_private_route_table.id
}


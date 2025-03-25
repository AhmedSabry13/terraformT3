output "vpc_id" {
  value = aws_vpc.t_my_vpc.id
}


output "cidr" {
  value = aws_vpc.t_my_vpc.cidr_block
}



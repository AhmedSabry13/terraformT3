output "subnets_with_az" {
  value = aws_subnet.t_my_subnet_1.availability_zone
}

output "subnet_ids" {
  description = "List of subnet IDs for the cluster"
 # type        = list(string)
  value = [aws_subnet.t_my_subnet_1.id, aws_subnet.t_my_subnet_2.id]
}


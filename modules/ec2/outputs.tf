output "instance_id" {
  value = aws_instance.apache_ec2.id
}

output "public_ip" {
  value = aws_instance.apache_ec2.public_ip
}
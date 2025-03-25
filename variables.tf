

variable "ami_image" {
  description = "used image ami"
  type        = string
  default     = "ami-08f9a9c699d2ab3f9"
}

variable "user_data_apache" {
  default = <<-EOF
              #!/bin/bash
              sudo dnf install -y httpd

              sudo systemctl start httpd
              sudo systemctl enable httpd

              sudo chown ec2-user: /var/www/html

              # Get the private IP address of the EC2 instance
              PRIVATE_IP=$(hostname -I | awk '{print $1}')

              # Create the index.html file with the private IP displayed
              echo "<h1>Hello from Sabry 1 terraform - Private IP: $PRIVATE_IP</h1>" > /var/www/html/index.html

              sudo systemctl restart httpd
              EOF
}

variable "vpc_id_sub" {
  description = "VPC ID for EKS"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "demo_sabry-cluster"
}

variable "key_name" {
  description = "SSH key for worker nodes"
  default     = "my-key"
}
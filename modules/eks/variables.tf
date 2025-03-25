
variable "cluster_name" {
  description = "EKS cluster name"
  default     = "my-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster"
  type        = list(string)
  #default = ["subnet-02a1a28780e118265" , "subnet-09362d865c39a31db"]
}

variable "vpc_id_eks" {
  description = "vpc id"
  
}
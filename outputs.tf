output "vpc_cidr_block" {
  value = module.vpc.cidr
}

output "subnets_with_az" {
  value = module.subnets.subnets_with_az
}

output "vpc_id_main" {
  value = module.vpc.vpc_id  

}

output "cluster_id" {
  value = module.eks.cluster_id  

}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint  

}

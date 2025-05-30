output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "public_ips" {
  value = module.ec2.public_ips
}

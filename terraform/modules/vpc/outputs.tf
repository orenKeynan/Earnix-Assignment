output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = [for sn in aws_subnet.subnet : sn.id]
}

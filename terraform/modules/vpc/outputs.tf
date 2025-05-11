output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for sn in aws_subnet.public : sn.id]
}

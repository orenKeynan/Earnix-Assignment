output "instance_ids" {
  description = "Map of instance name → ID"
  value       = { for name, inst in aws_instance.this : name => inst.id }
}

output "public_ips" {
  description = "Map of instance name → public IP"
  value       = { for name, inst in aws_instance.this : name => inst.public_ip }
}

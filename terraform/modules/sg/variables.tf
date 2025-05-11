variable "name" {
  description = "Name tag for the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where SG will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

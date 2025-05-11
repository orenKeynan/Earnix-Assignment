variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

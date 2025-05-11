variable "instances" {
  description = "List of EC2 instances to create"
  type = list(object({
    name               = string
    ami_id             = string
    instance_type      = string
    subnet_id          = string
    key_name           = string
    security_group_ids = list(string)
  }))
}

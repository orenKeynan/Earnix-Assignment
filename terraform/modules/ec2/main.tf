resource "aws_instance" "this" {
  for_each = { for inst in var.instances : inst.name => inst }

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = each.value.name
  }
}

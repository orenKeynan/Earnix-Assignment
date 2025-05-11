resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  for_each = { for idx, cidr in var.subnet_cidrs : idx => cidr }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = element(data.aws_availability_zones.available.names, each.key)

  tags = {
    Name = "${var.name}-${each.key}"
  }
}

data "aws_availability_zones" "available" {}

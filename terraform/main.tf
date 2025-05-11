data "external" "my_ip" {
  program = [
    "bash", "-c",
    "echo '{\"ip\":\"'$(curl -s -4 https://ifconfig.me)'\"}'"
  ]
}

locals {
  my_ip = data.external.my_ip.result.ip
}

# VPC + subnets
module "vpc" {
  source             = "./modules/vpc"
  name               = "earnix-vpc"
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24"]
}

# Secrutiy groups
module "sg" {
  source = "./modules/sg"
  name   = "web-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "SSH from my IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${local.my_ip}/32"] # my ip
    },
    {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

# EC2
module "ec2" {
  source    = "./modules/ec2"
  instances = [
    {
      name               = "web-1"
      ami_id             = "ami-0c94855ba95c71c99"
      instance_type      = "t3.micro"
      subnet_id          = module.vpc.public_subnet_ids[0]
      security_group_ids = [module.sg.security_group_id]
    }
  ]
}
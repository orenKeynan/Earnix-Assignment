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
  subnet_cidrs = ["10.0.1.0/24"]
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
## Using a manual created of EC2 key pair (and storing it in any Secret Management tool)
## created the key pair using: # create the key pair and save the private key locally
# aws ec2 create-key-pair --key-name oren-laptop --query "KeyMaterial" --output text > oren-laptop.pem


module "ec2" {
  source    = "./modules/ec2"
  instances = [
    {
      name               = "web-1"
      ami_id             = "ami-0f9de6e2d2f067fca" # Ubuntu 22
      instance_type      = "t3.micro"
      subnet_id          = module.vpc.subnet_ids[0]
      key_name           = "oren-laptop"
      security_group_ids = [module.sg.security_group_id]
    }
  ]
}
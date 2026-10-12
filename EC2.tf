module "ec2" {
  source             = "./modules/ec2"
  environment        = var.environment
  ami_id             = "ami-amazonlinux2023"
  vpc_id             = module.network.vpc_id
  vpc_cidr           = module.network.vpc_cidr
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}


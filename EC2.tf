module "ec2" {
  source             = "./modules/ec2"
  environment        = var.environment
  ami_id             = "ami-amazonlinux2023"
  vpc_id             = module.network.vpc_id
  vpc_cidr           = module.network.vpc_cidr
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}

module "lb" {
  source               = "./modules/lb"
  environment          = var.environment
  vpc_id               = module.network.vpc_id
  public_subnet_ids    = module.network.public_subnet_ids
  private_subnet_ids   = module.network.private_subnet_ids
  public_instance_ids  = module.ec2.public_instance_ids
  private_instance_ids = module.ec2.private_instance_ids
  public_alb_sg_id     = module.ec2.public_alb_sg_id
  internal_alb_sg_id   = module.ec2.internal_alb_sg_id
}

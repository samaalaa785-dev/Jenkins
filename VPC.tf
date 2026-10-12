module "network" {
  source      = "./modules/network"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  aws_region  = var.aws_region
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.environment}-bucket"
    Environment = var.environment
  }
}

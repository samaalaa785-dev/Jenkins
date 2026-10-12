resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.environment}-subnet"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.environment}-bucket"
    Environment = var.environment
  }
}

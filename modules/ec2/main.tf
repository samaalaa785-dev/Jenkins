resource "aws_security_group" "public_alb" {
  name   = "${var.environment}-public-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_alb" {
  name   = "${var.environment}-internal-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_app" {
  name   = "${var.environment}-public-app-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_app" {
  name   = "${var.environment}-private-app-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public_a" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.public_app.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.environment}-public-ec2-a"
  }
}

resource "aws_instance" "public_b" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_ids[1]
  vpc_security_group_ids      = [aws_security_group.public_app.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.environment}-public-ec2-b"
  }
}

resource "aws_instance" "private_a" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.private_app.id]
  associate_public_ip_address = false

  lifecycle {

    ignore_changes = [vpc_security_group_ids]

  }

  tags = {
    Name = "${var.environment}-private-ec2-a"
  }
}

resource "aws_instance" "private_b" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.private_subnet_ids[1]
  vpc_security_group_ids      = [aws_security_group.private_app.id]
  associate_public_ip_address = false

  lifecycle {

    ignore_changes = [vpc_security_group_ids]

  }

  tags = {
    Name = "${var.environment}-private-ec2-b"
  }
}

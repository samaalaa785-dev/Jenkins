resource "aws_security_group" "app" {
  name        = "${var.environment}-app-sg"
  description = "Security group for the simulated EC2 instance"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-app-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "app" {
  ami                         = "ami-amazonlinux2023"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.app.id]
  associate_public_ip_address = false

  tags = {
    Name        = "${var.environment}-app-ec2"
    Environment = var.environment
  }
}

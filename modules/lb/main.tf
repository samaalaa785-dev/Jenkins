resource "aws_lb" "public" {
  name               = "${var.environment}-public-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.public_alb_sg_id]
}

resource "aws_lb" "internal" {
  name               = "${var.environment}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.private_subnet_ids
  security_groups    = [var.internal_alb_sg_id]
}

resource "aws_lb_target_group" "public" {
  name     = "${var.environment}-public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group" "internal" {
  name     = "${var.environment}-internal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public.arn
  }
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal.arn
  }
}

resource "aws_lb_target_group_attachment" "public_a" {
  target_group_arn = aws_lb_target_group.public.arn
  target_id        = var.public_instance_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "public_b" {
  target_group_arn = aws_lb_target_group.public.arn
  target_id        = var.public_instance_ids[1]
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_a" {
  target_group_arn = aws_lb_target_group.internal.arn
  target_id        = var.private_instance_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_b" {
  target_group_arn = aws_lb_target_group.internal.arn
  target_id        = var.private_instance_ids[1]
  port             = 80
}

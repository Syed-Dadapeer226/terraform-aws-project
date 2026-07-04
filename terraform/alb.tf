# ALB Security Group
resource "aws_security_group" "alb-sg" {

  name        = "${var.project_name}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.my-vpc.id

  dynamic "ingress" {
    for_each = var.listeners

    content {
      description = ingress.key
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidrs
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# ALB
resource "aws_lb" "alb" {
  name                       = "${var.project_name}-alb"
  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = values(aws_subnet.public-subnet)[*].id
  enable_deletion_protection = false
  idle_timeout               = 60

}

# Target Group
resource "aws_lb_target_group" "alb-tg" {

  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.my-vpc.id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200"
  }

}

resource "aws_lb_target_group_attachment" "alb-tga" {

  for_each = aws_instance.ec2-server

  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = each.value.id
  port             = 80
}

# HTTP Listener
resource "aws_lb_listener" "listener" {

  for_each = {
    for k, v in var.listeners :
    k => v
    if v.protocol == "HTTP"
  }

  load_balancer_arn = aws_lb.alb.arn
  port              = each.value.port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }

}
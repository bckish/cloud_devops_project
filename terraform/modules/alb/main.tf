# =========================
# Application Load Balancer
# =========================
resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  subnets            = var.public_subnets
  security_groups    = [var.alb_sg]
  load_balancer_type = "application"
}

# =========================
# Backend Target Group
# =========================
resource "aws_lb_target_group" "backend" {
  name        = "${var.project_name}-backend-tg"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/docs"
    port                = "8000"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# =========================
# Frontend Target Group
# =========================
resource "aws_lb_target_group" "frontend" {
  name        = "${var.project_name}-frontend-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    matcher             = "200-399"
  }
}

# =========================
# Listener (Default → Frontend)
# =========================
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

# =========================
# Backend Routing Rule
# =========================
resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {
    path_pattern {
      values = ["/api/v1", "/api/v1/*", "/docs", "/openapi.json"]
    }
  }
}
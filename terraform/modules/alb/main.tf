resource "aws_lb" "alb" {
  subnets = var.public_subnets
  security_groups = [var.alb_sg]
}

resource "aws_lb_target_group" "tg" {
  port = 8000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}
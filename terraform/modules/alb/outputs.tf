output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "backend_tg" {
  value = aws_lb_target_group.backend.arn
}

output "frontend_tg" {
  value = aws_lb_target_group.frontend.arn
}
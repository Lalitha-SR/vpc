output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "web_tg_arn" {
  value = aws_lb_target_group.web.arn
}

output "api_tg_arn" {
  value = aws_lb_target_group.api.arn
}

output "admin_tg_arn" {
  value = aws_lb_target_group.admin.arn
}

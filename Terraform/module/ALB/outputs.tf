output "target_group_arn" {
  value = aws_lb_target_group.target_alb.arn
}
output "dns_name" {
  value = aws_lb.alb.dns_name
}
output "backend_lt" {
  value = aws_launch_template.backend_lt.id
}

output "backend_asg_name" {
  value = aws_autoscaling_group.asg.name
}
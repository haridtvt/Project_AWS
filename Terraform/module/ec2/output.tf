output "backend_lt" {
  value = aws_launch_template.backend_lt.id
}

output "backend_asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "asg_instance_ids" {
  value       = data.aws_instances.asg_instances.ids
}
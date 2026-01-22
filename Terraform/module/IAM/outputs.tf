output "ec2_profile_iam" {
  value       = aws_iam_instance_profile.ec2_profile.id                                          # The actual value to be outputted
}

output "backend_iam_role_name" {
  value = aws_iam_role.ec2_role.name
}

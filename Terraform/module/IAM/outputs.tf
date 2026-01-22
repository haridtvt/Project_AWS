output "ec2_profile_iam" {
  value       = aws_iam_instance_profile.ec2_profile.id                                          # The actual value to be outputted
}

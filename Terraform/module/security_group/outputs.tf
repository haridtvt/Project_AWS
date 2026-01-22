output "sg_alb" {
  value = aws_security_group.sg_alb.id
}
output "sg_ec2" {
  value = aws_security_group.sg_ec2.id
}
output "sg_rds" {
  value = aws_security_group.sg_rds.id
}
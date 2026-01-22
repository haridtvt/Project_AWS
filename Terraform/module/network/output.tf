output "vpc_id" {
  value  = aws_vpc.VPC.id
}

output "vpc_cidr_block" {
  value = aws_vpc.VPC.cidr_block
}

output "public_az1_subnet_id" {
  value = aws_subnet.public_az1.id
}

output "public_az2_subnet_id" {
  value = aws_subnet.public_az2.id
}

output "private_az1_subnet_id" {
  value = aws_subnet.private_az1.id
}

output "private_az2_subnet_id" {
  value = aws_subnet.private_az2.id
}

output "EIP_1" {
  value = aws_eip.EIP_az1.address
}
output "EIP_2" {
  value = aws_eip.EIP_az2.address
}
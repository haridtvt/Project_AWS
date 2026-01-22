output "backend_asg_name" {
  value = module.alb.dns_name
}

output "rds_endpoint" {
  value = module.rds.mysql_address
}

output "rds_port" {
  value = module.rds.rds_endpoint_port
}

output "db_secret_name" {
  value = module.rds.secret_manager_name
}

output "db_secret_arn" {
  value = module.rds.secret_manager_arn
}

output "frontend_bucket_name" {
  value = module.s3.frontend_bucket_name
}

output "frontend_website_url" {
  value = module.s3.endpoint_web
}

output "aws_region" {
  value = "ap-southeast-1"
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnet_ids" {
  value = [module.network.private_az1_subnet_id, module.network.private_az2_subnet_id]
}

output "backend_sg_id" {
  value = module.security-group.sg_ec2
}

output "backend_iam_role_name" {
  value = module.iam-role.backend_iam_role_name
}
module "network" {
  source = "./module/network/"
  cidr_block = var.cidr_block
  cidr_block_private_1 = var.cidr_block_private_1
  cidr_block_public_1 = var.cidr_block_public_1
  cidr_block_private_2 = var.cidr_block_private_2
  cidr_block_public_2 = var.cidr_block_public_2
  zone_1 = var.zone_1
  zone_2 = var.zone_2
}

module "security-group"{
  source = "./module/security_group"
  depends_on = [module.network]
  vpc_id = module.network.vpc_id
}

module "iam-role" {
  source = "./module/IAM"
}

module "alb" {
  source = "./module/ALB"
  depends_on = [module.network, module.security-group]
  alb_sg_id = module.security-group.sg_alb
  vpc_id = module.network.vpc_id
  subnet_alb1_id = module.network.public_az1_subnet_id
  subnet_alb2_id = module.network.public_az2_subnet_id
}

module "ec2" {
  source = "./module/ec2"
  depends_on = [module.network, module.security-group, module.iam-role, module.alb]
  subnet_id_ec2_1 = module.network.private_az1_subnet_id
  subnet_id_ec2_2 = module.network.private_az2_subnet_id
  sg_ec2_id = module.security-group.sg_ec2
  ec2_instance_profile = module.iam-role.ec2_profile_iam
  target_alb_arn = module.alb.target_group_arn
}

module "rds" {
  source = "./module/rds_mysql"
  db_class = "db.t3.micro"
  db_subnet_1 = module.network.private_az1_subnet_id
  db_subnet_2 = module.network.private_az2_subnet_id
  db_uname = var.uname
  db_pass = var.pass
  sg_db_id = module.security-group.sg_rds
}

module "s3" {
  source = "./module/s3"
}
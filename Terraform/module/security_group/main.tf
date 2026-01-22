resource "aws_security_group" "sg_alb" {
  name   = "sg_alb"
  vpc_id = var.vpc_id
  tags   = { Name = "sg_alb" }
}

resource "aws_security_group" "sg_ec2" {
  name = "sg_ec2"
  vpc_id = var.vpc_id
  tags = { Name = "sg_ec2" }
}

resource "aws_security_group" "sg_rds" {
  name = "sg_rds"
  vpc_id = var.vpc_id
  tags = { Name = "sg_rds" }
}

resource "aws_security_group_rule" "alb_ingress_443" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "alb_ingress_80" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "alb_egress_to_ec2" {
  type = "egress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_ec2.id
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "ec2_ingress_from_alb" {
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_alb.id
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "ec2_egress_to_rds" {
  type = "egress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_rds.id
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "ec2_egress_internet" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "rds_ingress_from_ec2" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_ec2.id
  security_group_id = aws_security_group.sg_rds.id
}
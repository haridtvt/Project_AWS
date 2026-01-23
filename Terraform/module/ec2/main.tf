data "aws_ami" "al2023" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "backend_lt" {
  name_prefix = "template-"
  image_id = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  iam_instance_profile {
    name = var.ec2_instance_profile  # IAM role
  }
  key_name = null
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp3"
      encrypted = true
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Role = "backend"
    }
  }
  network_interfaces {
    security_groups = [var.sg_ec2_id]
    associate_public_ip_address = false
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "backend-asg"
  desired_capacity = 2
  min_size = 1
  max_size = 4
  vpc_zone_identifier = [var.subnet_id_ec2_1, var.subnet_id_ec2_2]
  target_group_arns = [var.target_alb_arn]
  launch_template {
    id = aws_launch_template.backend_lt.id
    version = "$Latest"
  }
  health_check_type = "ELB"
  health_check_grace_period = 300
}

data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.asg.name
  }
  instance_state_names = ["running", "pending"]
}
resource "aws_lb" "alb" {
  name = "ALB"
  internal = false
  load_balancer_type = "application"
  security_groups= [var.alb_sg_id]
  subnets  = [var.subnet_alb1_id, var.subnet_alb2_id]
}

resource "aws_lb_target_group" "target_alb" {
  name = "backend-target-group"
  port = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path  = "/health"
    port  = "traffic-port"
    protocol  = "HTTP"
    matcher   = "200"
    interval  = 30
    timeout   = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port= "80"
  protocol= "HTTP"

  default_action {
    type   = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}

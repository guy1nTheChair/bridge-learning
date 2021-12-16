provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {}
}

resource "aws_instance" "ec2" {
  key_name               = var.key_pair
  ami                    = var.ami_id
  instance_type          = var.instance_type
  user_data              = file("user_data.sh")
  vpc_security_group_ids = var.security_group
  iam_instance_profile   = var.instance_profile
  tags                   = var.tags
  subnet_id              = var.ec2_subnet
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.app_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tga" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2.id
  port             = 80
}

resource "aws_lb" "alb" {
  name                       = "${var.app_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_group
  subnets                    = var.subnets
  enable_deletion_protection = false
  tags                       = var.tags
}
resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener" "listener-http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = var.dns
  type    = "CNAME"
  ttl     = "60"
  records = [aws_lb.alb.dns_name]
}
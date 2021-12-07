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
}

resource "aws_elb" "elb" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  access_logs {
    bucket        = "foo"
    bucket_prefix = "bar"
    interval      = 60
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.foo.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}

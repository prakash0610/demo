resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-${var.project}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = "test"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo su
              yum update -y
              yum install -y httpd
              echo "$(curl -s https://ipinfo.io/ip)" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
            EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.ec2_sg]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name_prefix         = "${var.environment}-${var.project}-asg"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = var.public_subnets 
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.project}-ec2"
    propagate_at_launch = true
  }
}

resource "aws_lb" "web_alb" {
  name               = "${var.environment}-${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = var.public_subnets

  enable_deletion_protection = false
  # we can use this if we have buckets created for alb log storage
  # access_logs {
  #   bucket  = var.logs_bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.environment}-${var.project}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

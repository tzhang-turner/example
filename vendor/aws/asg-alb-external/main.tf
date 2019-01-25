# Create/Update/Destroy the AWS resources dictated by variables.tf

# Configure the AWS Provider
provider "aws" {
  profile = "${var.aws_named_profile}"
  region  = "${var.region}"
}

# Provide user_data for instances or asg's
module "bootstrap" {
  source       = "../../argo-bootstrap"
  products     = "${var.products}"
  package_size = "${var.package_size}"
  customer     = "${var.customer}"
  conftag      = "${var.conftag}"
  owner        = "${var.owner}"
  environment  = "${var.environment}"
  chassis      = "EC2_VIRTUAL"
  location     = "${var.location}"
  nameservers  = "${var.nameservers}"
  network      = "prod"
  mkfs         = "${var.mkfs}"
  lvm          = "${var.lvm}"
}

# ALB
resource "aws_lb" "lb-tf" {
  name                       = "${var.name}-${var.environment}-tf"
  load_balancer_type         = "${var.lb_load_balancer_type}"
  enable_deletion_protection = "${var.lb_enable_deletion_protection}"
  ip_address_type            = "${var.lb_ip_address_type}"
  security_groups = ["${split(",", var.lb_specific_security_groups == "" ? lookup(var.aws_security_groups, var.aws_account) : var.lb_specific_security_groups)}"]
  internal                   = "${var.lb_internal_bool}"
  subnets                    = ["${split(",", lookup(var.aws_external_zone_identifiers, var.aws_account))}"]
  idle_timeout               = "${var.lb_idle_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name          = "${var.name}-${var.environment}-tf"
    environment   = "${var.environment}"
    customer      = "${var.customer}"
    team          = "${var.team}"
    product       = "${var.name}"
    description   = "${var.description}"
    contact-email = "${var.contact-email}"
  }
}

# TG
resource "aws_lb_target_group" "lbtg" {
  name                 = "${var.name}-${var.environment}-tg"
  target_type          = "${var.tg_target_type}"
  deregistration_delay = "${var.tg_deregistration_delay}"
  port                 = "${var.lb_listener_instance_port}"
  protocol             = "HTTP"
  vpc_id               = "${lookup(var.aws_vpc, var.aws_account)}"

  health_check {
    interval            = "${var.lb_health_check_interval}"
    timeout             = "${var.lb_health_check_timeout}"
    healthy_threshold   = "${var.lb_health_check_healthy_threshold}"
    unhealthy_threshold = "${var.lb_health_check_unhealthy_threshold}"
    path                = "${var.lb_health_check_target}"
    port                = "${var.tg_healthcheck_port}"
    protocol            = "${var.tg_healthcheck_protocol}"
    matcher             = "${var.tg_healthcheck_matcher}"
  }

  stickiness {
    type            = "${var.tg_stk_type}"
    cookie_duration = "${var.tg_stk_cookie_duration}"
    enabled         = "${var.tg_stk_enabled}"
  }

  tags {
    Name          = "${var.name}-${var.environment}-tf"
    environment   = "${var.environment}"
    customer      = "${var.customer}"
    team          = "${var.team}"
    product       = "${var.name}"
    description   = "${var.description}"
    contact-email = "${var.contact-email}"
  }
}

# Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.lb-tf.arn}"
  port              = "${var.lb_listener_lb_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.lbtg.arn}"
    type             = "forward"
  }
}

# LC
resource "aws_launch_configuration" "lc-tf" {
  name_prefix     = "${var.name}-${var.environment}-tf-"
  image_id        = "${var.aws_ami}"
  instance_type   = "${var.aws_instance_type}"
  security_groups = ["${split(",", var.asg_specific_security_groups == "" ? lookup(var.aws_security_groups, var.aws_account) : var.asg_specific_security_groups)}"]
  user_data       = "${module.bootstrap.user_data}"

  root_block_device {
    volume_type = "${var.aws_root_volume_type}"
    volume_size = "${var.aws_root_volume_size_in_gigabytes}"
    delete_on_termination = "${var.aws_root_volume_delete_on_termination}"
  }

  ebs_block_device {
    device_name = "${var.aws_data_volume_device_name}"
    volume_type = "${var.aws_data_volume_type}"
    volume_size = "${var.aws_data_volume_size_in_gigabytes}"
    delete_on_termination = "${var.aws_data_volume_delete_on_termination}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ASG
resource "aws_autoscaling_group" "asg-tf" {
  name       = "${var.name}-${var.environment}-tf"
  depends_on = ["aws_launch_configuration.lc-tf", "aws_lb.lb-tf"]

  #load_balancers       = ["${aws_lb.lb-tf.id}"]
  launch_configuration = "${aws_launch_configuration.lc-tf.name}"
  min_size             = "${var.asg_min_instances}"
  max_size             = "${var.asg_max_instances}"
  desired_capacity     = "${var.asg_desired_instances}"
  availability_zones   = ["${split( ",", lookup(var.aws_availability_zones, var.aws_account))}"]
  vpc_zone_identifier  = ["${lookup(var.aws_zone_identifiers, var.aws_account)}"]
  target_group_arns    = ["${aws_lb_target_group.lbtg.arn}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-${var.environment}-asg"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "application"
    value               = "${var.name}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "customer"
    value               = "${var.customer}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "team"
    value               = "${var.team}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "description"
    value               = "${var.description}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "contact-email"
    value               = "${var.contact-email}"
    propagate_at_launch = "true"
  }
}

output "asg_name" {
  value = "${aws_autoscaling_group.asg-tf.name}"
}
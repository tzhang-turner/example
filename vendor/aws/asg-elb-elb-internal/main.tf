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

resource "aws_elb" "elb-tf" {
  name            = "${var.name}-${var.environment}-tf"
  security_groups = ["${split(",", var.lb_specific_security_groups == "" ? lookup(var.aws_security_groups, var.aws_account) : var.lb_specific_security_groups)}"]
  subnets         = ["${split(",", lookup(var.aws_zone_identifiers, var.aws_account))}"]
  internal        = "true"
  idle_timeout    = "${var.elb_idle_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  listener {
    instance_port     = "${var.elb_listener_instance_port}"
    instance_protocol = "http"
    lb_port           = "${var.elb_listener_lb_port}"
    lb_protocol       = "http"
  }

  listener {
    instance_port      = "${var.elb_listener2_instance_port}"
    instance_protocol  = "http"
    lb_port           = "${var.elb_listener2_lb_port}"
    lb_protocol        = "http"
  }

  health_check {
    healthy_threshold   = "${var.elb_health_check_healthy_threshold}"
    unhealthy_threshold = "${var.elb_health_check_unhealthy_threshold}"
    timeout             = "${var.elb_health_check_timeout}"
    target              = "HTTP:${var.elb_listener_instance_port}${var.elb_health_check_target}"
    interval            = "${var.elb_health_check_interval}"
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

  lifecycle {
    create_before_destroy = true
  }
}

# ASG
resource "aws_autoscaling_group" "asg-tf" {
  name                 = "${var.name}-${var.environment}-tf"
  depends_on           = ["aws_launch_configuration.lc-tf", "aws_elb.elb-tf"]
  load_balancers       = ["${aws_elb.elb-tf.id}"]
  launch_configuration = "${aws_launch_configuration.lc-tf.name}"
  min_size             = "${var.asg_min_instances}"
  max_size             = "${var.asg_max_instances}"
  desired_capacity     = "${var.asg_desired_instances}"
  availability_zones   = ["${split( ",", lookup(var.aws_availability_zones, var.aws_account))}"]
  vpc_zone_identifier  = ["${lookup(var.aws_zone_identifiers, var.aws_account)}"]

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

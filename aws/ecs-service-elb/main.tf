provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_named_profile}"
}

resource "aws_elb" "ecs-elb-tf" {
  name            = "${var.name}-${var.environment}-tf"
  security_groups = ["${split(",", var.custom_security_groups == "" ? lookup(var.aws_security_groups, var.aws_account) : var.custom_security_groups)}"]
  subnets         = ["${split(",", lookup(var.aws_zone_identifiers, var.aws_account))}"]
  internal        = "${var.elb_internal_bool}"
  idle_timeout    = "${var.elb_idle_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = "${var.elb_health_check_healthy_threshold}"
    unhealthy_threshold = "${var.elb_health_check_unhealthy_threshold}"
    timeout             = "${var.elb_health_check_timeout}"
    target              = "HTTP:${var.instance_port}${var.healthcheck}"
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

resource "aws_ecs_task_definition" "main" {
  family                = "${var.name}-${var.environment}"
  network_mode          = "host"
  container_definitions = "${var.container_definitions}"
  cpu                   = "${var.task_cpu_reserved}"
  memory                = "${var.task_mem_limit}"
}

resource "aws_ecs_service" "main" {
  name                               = "${var.name}-${var.environment}"
  cluster                            = "${var.cluster_name}"
  task_definition                    = "${aws_ecs_task_definition.main.arn}"
  depends_on                         = ["aws_elb.ecs-elb-tf", "aws_ecs_task_definition.main"]
  launch_type                        = "EC2"
  desired_count                      = "${var.desired_count}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  load_balancer {
    elb_name       = "${aws_elb.ecs-elb-tf.name}"
    container_name = "${var.name}"
    container_port = "${var.instance_port}"
  }
}

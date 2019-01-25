variable "elb_listener_instance_port" {}

variable "elb_listener_lb_port" {}

variable "elb_health_check_target" {}

variable "elb_internal_bool" {
  default = "true"
}

variable "lb_specific_security_groups" {
  default = ""
}

variable "asg_specific_security_groups" {
  default = ""
}

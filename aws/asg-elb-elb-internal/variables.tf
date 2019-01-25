variable "elb_listener_instance_port" {}

variable "elb_listener_lb_port" {}

variable "elb_listener2_instance_port" {}

variable "elb_listener2_lb_port" {}

variable "elb_health_check_target" {}

variable "lb_specific_security_groups" { default = "" }

variable "asg_specific_security_groups" { default = "" }

variable "lb_listener_instance_port" {}

variable "lb_listener_lb_port" {}

variable "lb_health_check_target" {}

variable "lb_internal_bool" {
  default = "false"
}

variable "lb_load_balancer_type" {
  default = "application"
}

variable "lb_enable_deletion_protection" {}

variable "lb_ip_address_type" {}

variable "tg_deregistration_delay" {}

variable "tg_stk_type" {}

variable "tg_stk_cookie_duration" {}

# enable target_group stickiness
variable "tg_stk_enabled" {}

variable "tg_target_type" {}

variable "tg_healthcheck_port" {}

variable "tg_healthcheck_protocol" {}

variable "tg_healthcheck_matcher" {}

variable "aws_data_volume_delete_on_termination" {}
variable "aws_data_volume_device_name" {}
variable "aws_data_volume_size_in_gigabytes" {}
variable "aws_data_volume_type" {}

variable "lb_specific_security_groups" { default = "" }
variable "asg_specific_security_groups" { default = "" }

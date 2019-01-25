
variable "asg_specific_security_groups" { default = "" }

variable "aws_data_volume_delete_on_termination" {}
variable "aws_data_volume_device_name" {}
variable "aws_data_volume_size_in_gigabytes" {}
variable "aws_data_volume_type" {}

variable "elb_health_check_target" {}
variable "elb_internal_bool" { default = "true" }
variable "elb_listener_instance_port" {}
variable "elb_listener_lb_port" {}
variable "elb_specific_security_groups" { default = "" }



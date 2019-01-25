variable "elb_internal_bool" {
  default = "true"
}

variable "desired_count" {}
variable "cluster_name" {}
variable "instance_port" {}
variable "lb_port" {}
variable "container_definitions" {}
variable "deployment_maximum_percent" {}
variable "deployment_minimum_healthy_percent" {}
variable "task_cpu_reserved" {}
variable "task_mem_limit" {}

variable "custom_security_groups" {
  default = ""
}

variable "healthcheck" {}

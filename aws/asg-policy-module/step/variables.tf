variable "asg_name" {}

variable "asg_specific_security_groups" {
  default = ""
}

variable "scale-out-adjustment" {
  default = "1"
}

variable "scale-out-metric-interval-lower-bound" {}
variable "scale-out-metric-interval-upper-bound" {}

variable "scale-out-adjustment-type" {
  default = "ChangeInCapacity"
}

variable "scale-out-policy-type" {
  default = "StepScaling"
}

variable "scale-out-metric-aggregation-type" {
  default = "Average"
}

variable "scale-out-estimated-instance-warmup" {}
variable "scale-out-comparison-operator" {}
variable "scale-out-evaluation-periods" {}
variable "scale-out-metric-name" {}
variable "scale-out-namespace" {}
variable "scale-out-period" {}
variable "scale-out-statistic" {}
variable "scale-out-threshold" {}

variable "scale-in-adjustment" {
  default = "-1"
}

variable "scale-in-metric-interval-lower-bound" {
  default = ""
}

variable "scale-in-metric-interval-upper-bound" {
  default = "0"
}

variable "scale-in-adjustment-type" {
  default = "ChangeInCapacity"
}

variable "scale-in-policy-type" {
  default = "StepScaling"
}

variable "scale-in-metric-aggregation-type" {
  default = "Average"
}

variable "scale-in-estimated-instance-warmup" {}
variable "scale-in-comparison-operator" {}
variable "scale-in-evaluation-periods" {}
variable "scale-in-metric-name" {}
variable "scale-in-namespace" {}
variable "scale-in-period" {}
variable "scale-in-statistic" {}
variable "scale-in-threshold" {}

variable "notifications" {
  type        = "list"
  description = "List of events to associate with the auto scaling notification."
  default     = ["autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE", "autoscaling:EC2_INSTANCE_LAUNCH_ERROR", "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"]
}
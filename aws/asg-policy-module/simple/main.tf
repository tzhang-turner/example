## Creates simple scaling policy

# Configure the AWS Provider
provider "aws" {
  profile = "${var.aws_named_profile}"
  region  = "${var.region}"
}

resource "aws_autoscaling_policy" "asg_policy_simple-up" {
  name                   = "asg-policy-simple-up"
  autoscaling_group_name = "${var.asg_name}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "${var.scale-in-cooldown}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "${var.scale-out-adjustment}"
}

resource "aws_autoscaling_policy" "asg_policy_simple-down" {
  name                   = "asg-policy-simple-down"
  autoscaling_group_name = "${var.asg_name}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "${var.scale-out-cooldown}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "${var.scale-in-adjustment}"
}


## Creates CloudWatch monitors
resource "aws_cloudwatch_metric_alarm" "cpu-high-alarm" {
    alarm_name = "${var.name}-${var.environment}-high-cpu-tf"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "${var.scale-out-evaluation-periods}"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "${var.scale-in-period}"
    statistic = "Average"
    threshold = "${var.scale-out-threshold}"
    alarm_description = "This metric monitors ec2 cpu for high utilization on ASG instances"
    alarm_actions = [
        "${aws_autoscaling_policy.asg_policy_simple-up.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${var.asg_name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low-alarm" {
    alarm_name = "${var.name}-${var.environment}-low-cpu-tf"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "${var.scale-in-evaluation-periods}"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "${var.scale-out-period}"
    statistic = "Average"
    threshold = "${var.scale-in-threshold}"
    alarm_description = "This metric monitors ec2 cpu for low utilization on ASG instances"
    alarm_actions = [
        "${aws_autoscaling_policy.asg_policy_simple-down.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${var.asg_name}"
    }
}


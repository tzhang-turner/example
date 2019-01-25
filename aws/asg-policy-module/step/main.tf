# Create/Update/Destroy the AWS resources dictated by variables.tf

# Configure the AWS Provider
provider "aws" {
  profile = "${var.aws_named_profile}"
  region  = "${var.region}"
}

resource "aws_autoscaling_policy" "scale_up_bat" {
  name                      = "${var.name}-${var.environment}-tf"
  adjustment_type           = "${var.scale-out-adjustment-type}"
  autoscaling_group_name    = "${var.asg_name}"
  policy_type               = "${var.scale-out-policy-type}"
  metric_aggregation_type   = "${var.scale-out-metric-aggregation-type}"
  estimated_instance_warmup = "${var.scale-out-estimated-instance-warmup}"

  step_adjustment {
    scaling_adjustment          = "${var.scale-out-adjustment}"
    metric_interval_lower_bound = "${var.scale-out-metric-interval-lower-bound}"
    metric_interval_upper_bound = "${var.scale-out-metric-interval-upper-bound}"
  }
}

## Creates CloudWatch monitor
resource "aws_cloudwatch_metric_alarm" "cpu-high-alarm" {
  alarm_name          = "${var.name}-${var.environment}-high-cpu-tf"
  alarm_description   = "This metric monitors ec2 cpu for high utilization on ASG instances"
  comparison_operator = "${var.scale-out-comparison-operator}"
  evaluation_periods  = "${var.scale-out-evaluation-periods}"
  metric_name         = "${var.scale-out-metric-name}"
  namespace           = "${var.scale-out-namespace}"
  period              = "${var.scale-out-period}"
  statistic           = "${var.scale-out-statistic}"
  threshold           = "${var.scale-out-threshold}"

  dimensions = {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.scale_up_bat.arn}"]
}

resource "aws_autoscaling_policy" "scale_down" {
  name                      = "${var.name}-${var.environment}-sd-tf"
  adjustment_type           = "${var.scale-in-adjustment-type}"
  autoscaling_group_name    = "${var.asg_name}"
  policy_type               = "${var.scale-in-policy-type}"
  metric_aggregation_type   = "${var.scale-in-metric-aggregation-type}"
  estimated_instance_warmup = "${var.scale-in-estimated-instance-warmup}"

  step_adjustment {
    scaling_adjustment          = "${var.scale-in-adjustment}"
    metric_interval_lower_bound = "${var.scale-in-metric-interval-lower-bound}"
    metric_interval_upper_bound = "${var.scale-in-metric-interval-upper-bound}"
  }
}

## Creates CloudWatch monitor
resource "aws_cloudwatch_metric_alarm" "cpu-low-alarm" {
  alarm_name          = "${var.name}-${var.environment}-low-cpu-tf"
  alarm_description   = "This metric monitors ec2 cpu for low utilization on ASG instances"
  comparison_operator = "${var.scale-in-comparison-operator}"
  evaluation_periods  = "${var.scale-in-evaluation-periods}"
  metric_name         = "${var.scale-in-metric-name}"
  namespace           = "${var.scale-in-namespace}"
  period              = "${var.scale-in-period}"
  statistic           = "${var.scale-in-statistic}"
  threshold           = "${var.scale-in-threshold}"

  dimensions = {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.scale_down.arn}"]
}

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names = ["${var.asg_name}"]
  notifications = ["${var.notifications}"]
  topic_arn = "${aws_sns_topic.asg.arn}"
}

resource "aws_sns_topic" "asg" {
  name = "${var.name}-${var.environment}-topic"
  # arn is an exported attribute
}
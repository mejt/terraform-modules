resource "aws_cloudwatch_metric_alarm" "aurora_cpu_alarm_critical" {
  count                     = var.should_create_alarms ? var.desired_instances : 0
  alarm_name                = "${var.cluster_name}_cpu_critical-instance-${count.index}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = var.critical_cpu_threshold
  alarm_description         = "This metric monitors aurora RDS cpu utilization and reports that CPU is too high and needs to be looked at"
  alarm_actions             = [aws_sns_topic.sns_cpu_alert.arn]
  insufficient_data_actions = []
  treat_missing_data        = "ignore"

  dimensions = {
    DBInstanceIdentifier = "${var.cluster_name}-instance-${count.index}"
  }
}

resource "aws_sns_topic" "sns_cpu_alert" {
  name = "${var.cluster_name}_cpu_alert"
}


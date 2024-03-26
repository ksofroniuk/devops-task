resource "aws_cloudwatch_metric_alarm" "test" {
  alarm_name                = "test-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = 60
  statistic                 = "Maximum"
  threshold                 = 0
  alarm_description         = ""
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.test.arn]
  datapoints_to_alarm       = 1

  dimensions = {
    TargetGroup  = aws_lb_target_group.lb_target_group.arn_suffix
    LoadBalancer = aws_lb.lb.arn_suffix
  }
}

resource "aws_sns_topic" "test" {
  name = "Default_CloudWatch_Alarms_Topic"
}

resource "aws_sns_topic_subscription" "test" {
  topic_arn = aws_sns_topic.test.arn
  protocol  = "email"
  endpoint  = "xrq23551@fosiq.com" #https://10minutemail.net/
}
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS Running Task Count"
          period = 60
          stat   = "Average"
          metrics = [[
            "ECS/ContainerInsights", "RunningTaskCount",
            "ClusterName", "${var.project_name}-cluster",
            "ServiceName", "${var.project_name}-service"
          ]]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS CPU Utilization (%)"
          period = 60
          stat   = "Average"
          metrics = [[
            "AWS/ECS", "CPUUtilization",
            "ClusterName", "${var.project_name}-cluster",
            "ServiceName", "${var.project_name}-service"
          ]]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "ALB Request Count"
          period = 60
          stat   = "Sum"
          metrics = [[
            "AWS/ApplicationELB", "RequestCount",
            "LoadBalancer", aws_lb.main.arn_suffix
          ]]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "ALB Target Response Time (ms)"
          period = 60
          stat   = "Average"
          metrics = [[
            "AWS/ApplicationELB", "TargetResponseTime",
            "LoadBalancer", aws_lb.main.arn_suffix
          ]]
        }
      }
    ]
  })
}

resource "aws_autoscaling_group" "grupo" {
    name = var.groupName
    vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    health_check_type         = "ELB"
    health_check_grace_period = 600
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    launch_template {
        id = aws_launch_template.machine_aws.id
        version = "$Latest"
    }
  target_group_arns = [ aws_lb_target_group.target_lb.arn ] 
  termination_policies = ["Default"]
}

resource "aws_autoscaling_schedule" "development-up" {
  scheduled_action_name  = "development-up"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  time_zone = "Europe/London"
  recurrence = "00 08 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
}

# resource "aws_autoscaling_schedule" "development-down" {
#   scheduled_action_name  = "development-down"
#   min_size = 1
#   max_size = var.max_size
#   desired_capacity = 1
#   time_zone = "Europe/London"
#   recurrence = "00 23 * * 1-5"
#   autoscaling_group_name = aws_autoscaling_group.grupo.name
# }


# resource "aws_autoscaling_policy" "target_tracking_policy" {
#   name                   = "target_tracking_policy"
#   autoscaling_group_name = aws_autoscaling_group.grupo.name
#   policy_type            = "TargetTrackingScaling"

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = 60.0
#   }
# }

resource "aws_autoscaling_policy" "scaling_policy_up" {
  name                   = "scaling_policy_up"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  metric_aggregation_type = "Average"
  scaling_adjustment = 2
}

resource "aws_autoscaling_policy" "scaling_policy_down" {
  name                   = "scaling_policy_down"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  metric_aggregation_type = "Average"
  scaling_adjustment = -1
}

resource "aws_autoscaling_lifecycle_hook" "default" {
  name                   = "lifecycle-hook"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
  heartbeat_timeout      = 450 
  default_result         = "CONTINUE"
}



# if need to change the autoscaling policy use the below code
    # create a custom CloudWatch metric that measures the time it takes from when your 
    # main application sends a message to the queue until it receives the response from the API. 
    # Then, you can create an Auto Scaling policy that scales based on this custom metric.

# resource "aws_autoscaling_policy" "response_time_policy" {
#   name                   = "response_time_policy"
#   autoscaling_group_name = aws_autoscaling_group.grupo.name
#   policy_type            = "TargetTrackingScaling"

#   target_tracking_configuration {
#     customized_metric_specification {
#       namespace  = "MyApp"
#       metric_name = "ResponseTime"
#       statistic = "Average"
#       unit = "Seconds"
#     }
#     target_value = 4.0
#   }
# }

#import boto3

# cloudwatch = boto3.client('cloudwatch')

# cloudwatch.put_metric_data(
#     Namespace='MyApp',
#     MetricData=[
#         {
#             'MetricName': 'ResponseTime',
#             'Dimensions': [
#                 {
#                     'Name': 'QueueName',
#                     'Value': 'my-queue.fifo'
#                 },
#             ],
#             'Value': response_time,  # replace this with the actual response time
#             'Unit': 'Seconds',
#         },
#     ]
# )
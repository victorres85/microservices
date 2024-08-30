resource "aws_ecs_cluster" "felix-k8s_ecs_cluster" {
  name = "Cluster-${var.stack_name}"
}


resource "aws_ecs_task_definition" "felix-k8s_monolith_task" {
  family                   = "Felix-k8s-Mysfits-Monolith-Service-${var.stack_name}"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_service_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "monolith-service"
      image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.mono}:latest"
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "UPSTREAM_URL"
          value = aws_lb.felix-k8s_load_balancer.dns_name
        },
        {
          name  = "DDB_TABLE_NAME"
          value = aws_dynamodb_table.felix-k8s_dynamo_table.name
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.felix-k8s_monolith_log_group.name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "awslogs-felix-k8s-service"
        }
      }
      essential = true
    }
  ])
}

resource "aws_ecs_task_definition" "felix-k8s_task" {
  family                   = "Felix-k8s-Mysfits-Like-Service-${var.stack_name}"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_service_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "like-service"
      image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.like}:latest"
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "MONOLITH_URL"
          value = aws_lb.felix-k8s_load_balancer.dns_name
        },
        {
          name  = "CHAOSMODE"
          value = "on"
        },
        {
          name  = "LOGLEVEL"
          value = "ERROR"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.felix-k8s_log_group.name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "awslogs-felix-k8s-service"
        }
      }
      essential = true
    }
  ])
}

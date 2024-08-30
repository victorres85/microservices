resource "aws_iam_role" "ec2_ssm" {
  name = "ec2_ssm"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com", "lambda.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ssm_s3_rekognition" {
  name        = "ssm_s3_rekognition"
  description = "Policy to allow EC2 instances to access SSM Parameter Store, S3, and Rekognition"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters",
        "ssm:GetParameter",
        "s3:*",
        "rekognition:*",
        "autoscaling:DescribeAutoScalingGroups",
        "ec2:DescribeInstances",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces", 
        "ec2:DeleteNetworkInterface",
        "cloudwatch:*",
        "sqs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    client  = "purina-felix"                         
    project = "quiz"
  }
}
resource "aws_iam_policy" "cloudwatch" {
  name        = "CloudWatchPutMetricData"
  description = "Allows EC2 instances to put metric data to CloudWatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "cloudwatch:PutMetricData",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "cloudfront_s3_access" {
  name        = "cloudfront_s3_access"
  description = "Allows access to CloudFront distributions and S3 objects"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:GetDistribution",
        "cloudfront:ListDistributions",
        "cloudfront:CreateInvalidation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_cloudfront_s3_access" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = aws_iam_policy.cloudfront_s3_access.arn
}
resource "aws_iam_role_policy_attachment" "ec2_ssm_s3_rekognition" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = aws_iam_policy.ssm_s3_rekognition.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.ec2_ssm.name
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_cloudwatch" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}



resource "aws_iam_role" "ecs_service_role" {
  name = "EcsServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs-service"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "ec2:AttachNetworkInterface",
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:DeleteNetworkInterface",
            "ec2:DeleteNetworkInterfacePermission",
            "ec2:Describe*",
            "ec2:DetachNetworkInterface",
            "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
            "elasticloadbalancing:DeregisterTargets",
            "elasticloadbalancing:Describe*",
            "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
            "elasticloadbalancing:RegisterTargets",
            "iam:PassRole",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:DescribeLogStreams",
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
          ]
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ECSTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "AmazonECSTaskRolePolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:UpdateItem",
            "dynamodb:GetItem"
          ]
          Resource = aws_dynamodb_table.felix-k8s_dynamo_table.arn
        },
        {
          Effect = "Allow"
          Action = [
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords",
            "xray:GetSamplingRules",
            "xray:GetSamplingTargets",
            "xray:GetSamplingStatisticSummaries"
          ]
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_instance_profile" "felix-k8s_profile" {
  name = "FelixK8sProfile"
  role = aws_iam_role.ecs_task_role.name
}


resource "aws_iam_role" "codepipeline_service_role" {
  name = "CodePipelineServiceRole"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "root"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "s3:PutObject"
          ]
          Resource = "arn:aws:s3:::*"
        },
        {
          Effect = "Allow"
          Action = [
            "codecommit:*",
            "codebuild:StartBuild",
            "codebuild:BatchGetBuilds",
            "iam:PassRole",
            "iam:CreateRole",
            "iam:DetachRolePolicy",
            "iam:AttachRolePolicy",
            "iam:PutRolePolicy",
            "cloudwatch:*"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "ecs:*"
          ]
          Resource = "*"
        }
      ]
    })
  }
}


resource "aws_iam_role" "codebuild_service_role" {
  name = "${var.stack_name}-CodeBuildServiceRole"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  ]

  inline_policy {
    name = "root"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ecr:GetAuthorizationToken"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "s3:GetObject",
            "s3:PutObject",
            "s3:GetObjectVersion"
          ]
          Resource = "arn:aws:s3:::${var.mythical_artifact_bucket}/*"
        },
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = [
            "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/${var.felix-k8s_log_group}/codebuild/tests/",
            "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/${var.felix-k8s_log_group}/codebuild/tests:*"
          ]
        },
        {
          Effect = "Allow"
          Action = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion"
          ]
          Resource = "arn:aws:s3:::codepipeline-${var.aws_region}-*"
        }
      ]
    })
  }
}

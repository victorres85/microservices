resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.vpc-k8s.id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_endpoint_type = "Interface" 
  route_table_ids = [
    aws_route_table.private_one.id,
    aws_route_table.private_two.id,
  ]
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Principal": "*",
      "Resource": "*"
    }
  ]
}
POLICY
}
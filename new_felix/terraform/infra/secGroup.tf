resource "aws_security_group" "felix-k8s_load_balancer_sg" {
  name        = "SecurityGroup-${var.stack_name}"
  description = "Access to the load balancer"
  vpc_id      = aws_vpc.vpc-k8s.id

  ingress {
    description = "Allow access to ALB from anywhere on the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

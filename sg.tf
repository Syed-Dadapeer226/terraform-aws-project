resource "aws_security_group" "web-sg" {
  name        = "$(var.project_name)-sg"
  description = "EC2 Security Group"
  vpc_id      = aws_vpc.my-vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Allow all outbound traffic"
  }

}
# Security Group for only "Bastion Host"
resource "aws_security_group" "bastion-sg" {
  name        = "${var.project_name}-bastion-sg"
  description = "Bastion Host Security Group"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP for better security
    description = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${local.name}-bastion-sg"
  }

}

# Security Group for "all other instances" except "Bastion Host"
resource "aws_security_group" "web-sg" {
  name        = "${var.project_name}-web-sg"
  description = "EC2 Security Group"
  vpc_id      = aws_vpc.my-vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [ aws_security_group.alb-sg.id ]
      description = "Allow ${ingress.value} port"
    }
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
    description     = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${local.name}-web-sg"
  }

}
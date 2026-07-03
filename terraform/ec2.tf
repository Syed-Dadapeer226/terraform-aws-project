# Bastion Host - Public subnet
resource "aws_instance" "bastion-host" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = local.first_public_subnet
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${local.name}-Bastion-Host"
  }
}

# EC2 instances - Private Subnet
resource "aws_instance" "ec2-server" {
  for_each = var.instance_names

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-subnet[each.value.subnet].id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  user_data_base64       = base64encode(file("userdata.sh"))

  tags = {
    Name = "${local.name}-instance"
  }
}

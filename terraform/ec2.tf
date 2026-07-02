resource "aws_instance" "ec2-server" {
  for_each = var.instance_names

  ami              = data.aws_ami.amazon_linux.id
  instance_type    = var.instance_type
  vpc_security_group_ids = [ aws_security_group.web-sg.id ]
  subnet_id        = aws_subnet.private-subnet[each.value.private_subnet].id
  key_name         = var.key_name
  user_data_base64 = base64encode(file("userdata.sh"))

  tags = {
    Name = "$(local.name)-instance"
  }
}
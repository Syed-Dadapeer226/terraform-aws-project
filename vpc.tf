# VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.name
  }
}

# Public Subnet
resource "aws_subnet" "public-subnet" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.my-vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = true
}

# Private Subnet
resource "aws_subnet" "private-subnet" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.my-vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id
}

# Elastic IP
resource "aws_eip" "nat" {
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.gw
  ]
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public-subnet)[0].id

  depends_on = [
    aws_internet_gateway.gw
  ]
}

# Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}

resource "aws_route_table_association" "public-rta" {
  for_each = aws_subnet.public-subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}


# Private Route Table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }  

}

resource "aws_route_table_association" "private-rta" {
  for_each = aws_subnet.private-subnet

  subnet_id = each.value.id
  route_table_id = aws_route_table.private-rt.id
}
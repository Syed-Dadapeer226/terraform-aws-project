output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "region" {
  value = data.aws_region.current.region
}

# VPC
output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

# EC2
output "instance_ids" {

  value = {
    for k, v in aws_instance.ec2-server :
    k => v.id
  }

}

output "public_ips" {

  value = {
    for k, v in aws_instance.ec2-server :
    k => v.public_ip
  }

}

output "private_ips" {

  value = {
    for k, v in aws_instance.ec2-server :
    k => v.private_ip
  }

}

# ALB
output "alb_dns_name" {

  value = {
    for k, v in aws_lb.alb :
    k => v.dns_name
  }
  
}
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

# Bastion Host
output "bastion_instance_id" {

  value = aws_instance.bastion-host.id

}

output "bastion_public_ip" {

  value = aws_instance.bastion-host.public_ip

}

# Web Instances
output "web_instance_ids" {

  value = {
    for k, v in aws_instance.ec2-server :
    k => v.id
  }

}

output "web_private_ips" {

  value = {
    for k, v in aws_instance.ec2-server :
    k => v.private_ip
  }

}

# ALB
output "alb_dns_name" {

  value = aws_lb.alb.dns_name

}
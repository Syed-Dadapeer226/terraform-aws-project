variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "project_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

# VPC
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "public_subnets" {
  description = "Map of public subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

# EC2
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_names" {
  type = map(object({
    subnet = string
  }))
}

variable "allowed_ports" {
  type    = list(number)
  default = [80]
}

# ALB
variable "internal" {
  type    = bool
  default = false
}

variable "allowed_cidrs" {
  type = list(string)

  default = [
    "0.0.0.0/0"
  ]
}

variable "listeners" {

  type = map(object({
    port     = number
    protocol = string
  }))

  default = {
    http = {
      port     = 80
      protocol = "HTTP"
    }
  }

}
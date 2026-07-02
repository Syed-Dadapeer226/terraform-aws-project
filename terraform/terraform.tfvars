aws_region = "ap-south-1"

project_name = "terraform-project"

environment = "prod"

# VPC
vpc_cidr = "10.0.0.0/16"

public_subnets = {
  public-a = {
    cidr = "10.0.1.0/24"
    az   = "ap-south-1a"
  }

#   public-b = {
#     cidr = "10.0.2.0/24"
#     az   = "ap-south-1b"
#   }
}

private_subnets = {
  private-a = {
    cidr = "10.0.101.0/24"
    az   = "ap-south-1a"
  }

  private-b = {
    cidr = "10.0.102.0/24"
    az   = "ap-south-1b"
  }
}

# EC2
instance_names = {
  web-01 = {
    private_subnet = "private-a"
  }

  web-02 = {
    private_subnet = "private-b"
  }

}

key_name = "my-keypair"

allowed_ports = [
  22,
  80
]

# ALB
internal = false

allowed_cidrs = [
  "0.0.0.0/0"
]

listeners = {

  http = {
    port     = 80
    protocol = "HTTP"
  }

}

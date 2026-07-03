locals {

  name = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

}

locals {
  first_public_subnet = values(aws_subnet.public-subnet)[0].id
}

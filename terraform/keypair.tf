# Generate an ED25519 SSH key pair
resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

# Import the public key into AWS
resource "aws_key_pair" "key_pair" {
  key_name   = "terraform-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/terraform-key.pem"
  content         = tls_private_key.ssh.private_key_openssh
  file_permission = "0400"
}
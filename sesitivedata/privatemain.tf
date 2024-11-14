# Generate Private Key
resource "tls_private_key" "devk1" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create AWS Key Pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-dev-250-key"
  public_key = tls_private_key.devk1.public_key_openssh

  tags = {
    Name = "ec2-dev-tls-key"
  }
}

# Save the Private Key to a .pem File
resource "local_file" "devk1_pem" {
  filename        = "ec2-dev-250-key.pem"
  content         = tls_private_key.devk1.private_key_pem
  file_permission = "0400" # Ensure the file is only readable by the owner
}



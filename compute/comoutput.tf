output "publicip" {
  value = aws_instance.dev-web1.public_ip
}
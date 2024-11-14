resource "aws_instance" "dev-web1" {
  ami =  "ami-0da424eb883458071"
  instance_type = "t2.micro"
  subnet_id = var.subnet1
  security_groups = [var.securitygroup1]
  #vpc_security_group_ids = [ aws_security_group.dev-sg.id ]
  key_name = "ec2-dev-250-key"
  #user_data = file("webinstall.sh")
  user_data = <<-EOF
    #!bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "welcome to web server depolyed using TF" >/var/www/html/index.html
    EOF
  tags = {
    "Name" = var.dev_web1
  }
}
#Create VPC - 10.250.0.0/16
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.222.0.0/16"
  tags = {
    "Name" = var.vpc27
  }
}
#Create Subnet - 10.250.1.0/24
resource "aws_subnet" "websunet1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.222.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet1
  }
}
#creating 2nd web server
resource "aws_subnet" "websunet2" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.222.2.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet2
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "dev-igway" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    "Name" = "dev-250-igateway"
  }
}

#Create Route Table - attached with subnet
resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id
}
#Create Route in Route Table for Internet Access
resource "aws_route" "dev-route" {
  route_table_id         = aws_route_table.dev-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-igway.id
}

#Associate Route Table with Subnet
resource "aws_route_table_association" "dev-rt-assoc" {
  route_table_id = aws_route_table.dev-rt.id
  subnet_id      = aws_subnet.websunet1.id
}

#Create Security Group in the VPC with port 80, 22 as inbound open
resource "aws_security_group" "dev-sg" {
  name        = "dev-web-ssh-sg"
  vpc_id      = aws_vpc.dev-vpc.id
  description = "Dev web server traffic allowed ssh & http"

}

resource "aws_vpc_security_group_ingress_rule" "dev-ingress-22" {
  security_group_id = aws_security_group.dev-sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "dev-ingress-80" {
  security_group_id = aws_security_group.dev-sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "dev-egress" {
  security_group_id = aws_security_group.dev-sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

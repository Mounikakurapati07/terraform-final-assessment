output "vpcoutput" {
  value =aws_vpc.dev-vpc.id
}
output "cidroutput" {
  value = aws_vpc.dev-vpc.cidr_block
}
output "subnetid1" {
  value = aws_subnet.websunet1.id
}
output "securitygroup1" {
  value =aws_security_group.dev-sg.id
}
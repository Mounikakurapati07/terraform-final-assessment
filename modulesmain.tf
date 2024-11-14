
module "network" {
  source = "./network"
  subnet2 = "dev_subnet22"
}

module "compute" {
  source = "./compute"
  
  dev_web1 ="dev27_webuser"
  subnet1 = module.network.subnetid1
  securitygroup1 = module.network.securitygroup1
}
output "module_compute_output" {
  value = module.compute
}

output "network_output" {
  value =module.network
}

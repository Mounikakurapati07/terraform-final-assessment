terraform {
  
  required_providers {
    aws = {
      #using version constraint
      source = "hashicorp/aws"
      #version = ">5.70"
      #version = "=5.70.0"
    }
    
  }
}

provider "aws" {
  region     = "us-west-1"
  
}
provider "local" {
  
}
provider "random" {
  
}
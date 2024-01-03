locals {

  vpc_cidr = "10.22.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  
}
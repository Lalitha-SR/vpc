locals {
  azs = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 4, 0),
    cidrsubnet(var.vpc_cidr, 4, 1),
  ]

  private_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 4, 2), 
    cidrsubnet(var.vpc_cidr, 4, 3),
  ]
}

# 10.0.0.0/24 => total ip = 2^32-24= 256ips ==> 10.0.0.0-10.0.0.255 == > usable ip in aws 251

# 00001010.00000000.00000000.0000 0000/24 =>10.0.0.0/28 ==> 16-5= 11ips 
# 00001010.00000000.00000000.0001 0000/24 =>10.0.0.16/28 ==>11 ips
# 00001010.00000000.00000000.0010 0000/24 =>10.0.0.32/28 ==>11 ips
# 00001010.00000000.00000000.0011 0000/24 =>10.0.0.48/28 ==>11ips


# we have used around 64 ips and 192 ips are free 
module "vpc_external" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "vpc-external"

  cidr = var.vpc_external_cidr

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  intra_subnet_tags   = { "Subnet-Type" : "intra" }
  private_subnet_tags = { "Subnet-Type" : "private" }
  public_subnet_tags  = { "Subnet-Type" : "public" }

  intra_subnets = [
    cidrsubnet(var.vpc_external_cidr, 8, 0),
    cidrsubnet(var.vpc_external_cidr, 8, 1),
    cidrsubnet(var.vpc_external_cidr, 8, 2)
  ]

  private_subnets = [
    cidrsubnet(var.vpc_external_cidr, 8, 4),
    cidrsubnet(var.vpc_external_cidr, 8, 5),
    cidrsubnet(var.vpc_external_cidr, 8, 6)
  ]

  public_subnets = [
    cidrsubnet(var.vpc_external_cidr, 8, 8),
    cidrsubnet(var.vpc_external_cidr, 8, 9),
    cidrsubnet(var.vpc_external_cidr, 8, 10)
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}


module "vpc_internal" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "vpc-internal"

  cidr = var.vpc_internal_cidr

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  intra_subnet_tags   = { "Subnet-Type" : "intra" }
  private_subnet_tags = { "Subnet-Type" : "private" }

  intra_subnets = [
    cidrsubnet(var.vpc_internal_cidr, 8, 0),
    cidrsubnet(var.vpc_internal_cidr, 8, 1),
    cidrsubnet(var.vpc_internal_cidr, 8, 2)
  ]

  private_subnets = [
    cidrsubnet(var.vpc_internal_cidr, 8, 4),
    cidrsubnet(var.vpc_internal_cidr, 8, 5),
    cidrsubnet(var.vpc_internal_cidr, 8, 6)
  ]

  enable_nat_gateway   = false
  enable_dns_hostnames = true
}

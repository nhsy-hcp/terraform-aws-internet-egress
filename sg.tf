module "sg_external" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.17.0"

  name        = "vpc-external"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc_external.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "sg_internal" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.17.0"

  name        = "vpc-internal"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc_internal.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}


#module "ec2_external_public" {
#  source  = "terraform-aws-modules/ec2-instance/aws"
#  version = "4.3.0"
#
#  name = "ec2-external-public"
#
#  ami               = data.aws_ami.amazon_linux.id
#  instance_type     = "t3.micro"
#  availability_zone = element(module.vpc_external.azs, 0)
#  subnet_id         = element(module.vpc_external.public_subnets, 0)
#
#  associate_public_ip_address = true
#
#  create_iam_instance_profile = true
#
#  user_data = file("files/ec2-userdata.sh")
#
#  iam_role_policies = {
#    SSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#  }
#
#  vpc_security_group_ids = [
#    module.sg_external.security_group_id
#  ]
#
#  depends_on = [
#    module.vpc_internal
#  ]
#}

module "ec2_external_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "ec2-external-private"

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  availability_zone = element(module.vpc_external.azs, 0)
  subnet_id         = element(module.vpc_external.private_subnets, 0)

  associate_public_ip_address = false

  create_iam_instance_profile = true

  user_data = file("files/ec2-userdata.sh")

  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  vpc_security_group_ids = [
    module.sg_external.security_group_id
  ]

  depends_on = [
    module.vpc_internal
  ]
}

module "ec2_internal" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "ec2-internal"

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  availability_zone = element(module.vpc_internal.azs, 0)
  subnet_id         = element(module.vpc_internal.private_subnets, 0)

  associate_public_ip_address = false

  create_iam_instance_profile = true

  user_data = file("files/ec2-userdata.sh")

  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  vpc_security_group_ids = [
    module.sg_internal.security_group_id
  ]

  depends_on = [
    module.vpc_internal,
    aws_ec2_transit_gateway_vpc_attachment.internal
  ]
}

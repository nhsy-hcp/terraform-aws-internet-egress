resource "aws_ec2_transit_gateway" "shared" {
  amazon_side_asn                = 65101
  auto_accept_shared_attachments = "enable"
  description                    = "X-Account Transit Gateway"

  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  dns_support = "enable"

  tags = {
    "Name" : "tgw-shared"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "external" {
  transit_gateway_id = aws_ec2_transit_gateway.shared.id
  vpc_id             = module.vpc_external.vpc_id

  subnet_ids = module.vpc_external.intra_subnets

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = {
    "Name" : "tgw-attach-external"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "internal" {
  transit_gateway_id = aws_ec2_transit_gateway.shared.id
  vpc_id             = module.vpc_internal.vpc_id

  subnet_ids = module.vpc_internal.intra_subnets

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true



  tags = {
    "Name" : "tgw-attach-internal"
  }
}

resource "aws_ec2_transit_gateway_route" "shared_default_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.external.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.shared.association_default_route_table_id
}

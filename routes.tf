resource "aws_route" "internet_default_route" {
  for_each = toset(concat(
    module.vpc_external.intra_route_table_ids
  ))
  route_table_id         = each.value
  nat_gateway_id         = element(module.vpc_external.natgw_ids, 0)
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "internal_default_route" {
  for_each = toset(concat(
    module.vpc_internal.intra_route_table_ids,
    module.vpc_internal.private_route_table_ids
  ))
  route_table_id         = each.value
  transit_gateway_id     = aws_ec2_transit_gateway.shared.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "internet_vpc_to_internal_vpc" {
  for_each = toset(concat(
    module.vpc_external.intra_route_table_ids,
    module.vpc_external.private_route_table_ids,
    module.vpc_external.public_route_table_ids
  ))
  route_table_id         = each.value
  transit_gateway_id     = aws_ec2_transit_gateway.shared.id
  destination_cidr_block = var.vpc_internal_cidr
}

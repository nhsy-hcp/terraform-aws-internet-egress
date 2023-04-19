variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_external_cidr" {
  type    = string
  default = "10.64.0.0/16"
}

variable "vpc_internal_cidr" {
  type    = string
  default = "10.65.0.0/16"
}

variable "aws_account_id" {
  type = string
}

variable "owner" {
  type = string
}

variable "tgw_amazon_side_asn" {
  type    = string
  default = "65101"
}
output "ec2-external-private-id" {
  value = module.ec2_external_private.id
}

output "ec2-internal-id" {
  value = module.ec2_internal.id
}

output "ec2-external-private-ip" {
  value = module.ec2_external_private.private_ip
}

output "ec2-internal-ip" {
  value = module.ec2_internal.private_ip
}

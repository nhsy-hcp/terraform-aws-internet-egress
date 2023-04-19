.PHONY: all init deploy plan destroy fmt clean

all: init deploy

init: fmt
	@aws sts get-caller-identity
	@terraform init

deploy: init
	@terraform validate
	@terraform apply -auto-approve \
		-target module.vpc_external \
		-target module.vpc_internal \
		-target aws_ec2_transit_gateway.shared \
		-target aws_ec2_transit_gateway_vpc_attachment.external \
		-target aws_ec2_transit_gateway_vpc_attachment.internal
#	@cp routes.tf.tpl routes.tf
#	@terraform init
	@terraform apply -auto-approve

plan: init
	@terraform validate
	@terraform plan

destroy: init
	@terraform destroy -auto-approve
#	-@rm routes.tf

fmt:
	@terraform fmt -recursive

clean:
	-rm -rf .terraform/
	-rm .terraform.lock.hcl
	-rm terraform.tfstate*

.PHONY: all init deploy plan destroy fmt clean

all: deploy

init: fmt
	@aws sts get-caller-identity
	@terraform init

deploy: init
	@terraform apply -auto-approve
	@cp routes.tf.tpl routes.tf
	@terraform apply -auto-approve

plan: init
	@terraform validate
	@terraform plan

destroy: init
	@terraform destroy -auto-approve
	-@rm routes.tf

fmt:
	@terraform fmt -recursive

clean:
	-rm -rf .terraform/
	-rm .terraform.lock.hcl
	-rm terraform.tfstate*

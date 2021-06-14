SHELL=/bin/bash
tfvars=$(CURDIR)/gcp/terraform.tfvars
images=$(CURDIR)/images
build=$(CURDIR)/build

.PHONY: images

encode:
	cat $(tfvars) | sed -e 's/^gcp_creds_file.*/gcp_creds_file = "TERRAFORM_SVCACCT"/' | base64 -w 0 

images:
	cd $(images); make all

package:
	@if [ ! -d "$(build)" ]; then mkdir "$(build)"; fi
	rsync -avz $(images)/build/ $(build)
	rsync $(images)/docker-compose.yaml $(build)

rsync:
	[ ! -z "$(remote)" ] && rsync -avz $(build) $(remote)

push-ssl:
	podman cp $(pki)/issued/localhost.key  nginx:/etc/ssl/localhost.crt
	podman cp $(pki)/private/localhost.key nginx:/etc/ssl/localhost.key
	podman cp $(pki)/dh.pem	               nginx:/etc/ssl/dh.pem

SHELL=/bin/bash
tfvars=$(CURDIR)/gcp/terraform.tfvars
images=$(CURDIR)/images
build=$(CURDIR)/build
img_build=$(build)/images

.PHONY: images

encode:
	cat $(tfvars) | sed -e 's/^gcp_creds_file.*/gcp_creds_file = "TERRAFORM_SVCACCT"/' | base64 -w 0 

images: build-images

build-images:
	cd $(images); make all

rsync:
	rsync -avz $(images)/build $(remote)

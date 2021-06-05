SHELL=/bin/bash
tfvars=$(CURDIR)/gcp/terraform.tfvars
images=$(CURDIR)/images
build=$(CURDIR)/build
img_build=$(build)/images

.PHONY: images

encode:
	cat $(tfvars) | sed -e 's/^gcp_creds_file.*/gcp_creds_file = "TERRAFORM_SVCACCT"/' | base64 -w 0 

images: clean-images build-images link-images

build-images:
	cd $(images); make all

link-images:
	if [ ! -d $(img_build) ]; then mkdir -p $(img_build); fi
	ln -s $(images)/build/* $(img_build)

clean-images:
	if [ -d $(img_build) ]; then rm -r $(img_build); fi

SHELL=/bin/bash
tfvars=$(CURDIR)/gcp/terraform.tfvars
images=$(CURDIR)/images
build=$(CURDIR)/build
tor=`realpath $(CURDIR)/.local/tor`

.PHONY: images

encode:
	cat $(tfvars) | sed -e 's/^gcp_creds_file.*/gcp_creds_file = "TERRAFORM_SVCACCT"/' | base64 -w 0 

images:
	cd $(images); make all

package:
	@if [ ! -d "$(build)" ]; then mkdir "$(build)"; fi
	rsync -avz $(images)/build/ $(build)
	rsync -avz $(images)/up.sh $(build)
	if [ ! -z "$$REMOTE_DIR" ]; then rsync -avz $(build) $$REMOTE_DIR; fi

push-secrets:
	podman --remote cp $(tor) tor:/var/lib/tor/svc

sync-ipfs:
	cd $(images); make ipfs
	make package

sync-nginx:
	cd $(images); make nginx
	make package

sync-varnish:
	cd $(images); make varnish
	make package

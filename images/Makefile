SHELL=/bin/bash
build=$(CURDIR)/build

.PHONY: certbot nginx ipfs tor varnish

all: exec certbot nginx ipfs tor varnish

build:
	@if [ ! -d $(build) ]; then mkdir $(build); fi

certbot: build
	@echo 'building certbot'; echo ''
	@BUILD=$(build) $(CURDIR)/certbot/build.sh >/dev/null

nginx: build
	@cd $(CURDIR)/nginx; if [ -z "$(runas)" ]; then make all build=$(build); else make $(runas) build=$(build); fi

ipfs: build
	@echo 'building ipfs'; echo ''
	@BUILD=$(build) $(CURDIR)/ipfs/build.sh >/dev/null

tor: build
	@echo 'building tor'; echo ''
	@BUILD=$(build) $(CURDIR)/tor/build.sh >/dev/null

varnish: build
	@echo 'building varnish'; echo ''
	@BUILD=$(build) $(CURDIR)/varnish/build.sh >/dev/null

exec:
	for i in $$(find $(CURDIR) -type f | grep 'docker-entrypoint\.sh\|setup\.sh'); do chmod +x $$i; done

debug-config:
	podman inspect -t image localhost/$(img) | jq --raw-output '.[0].Config'

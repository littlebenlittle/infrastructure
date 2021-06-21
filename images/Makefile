SHELL=/bin/bash
build=$(CURDIR)/build

.PHONY: build certbot nginx ipfs tor varnish

all: exec certbot nginx ipfs tor varnish

build:
	@if [ ! -d $(build)/user ]; then mkdir -p $(build)/user; fi
	@if [ ! -d $(build)/root ]; then mkdir $(build)/root; fi

certbot: build
	@echo 'building certbot'; echo ''
	@BUILD=$(build)/root $(CURDIR)/certbot/build.sh >/dev/null

nginx: nginx-user nginx-root

nginx-user: build
	@cd $(CURDIR)/nginx; make user build=$(build)/user

nginx-root: build
	@cd $(CURDIR)/nginx; make root build=$(build)/root

ipfs: build
	@echo 'building ipfs'; echo ''
	@BUILD=$(build)/user $(CURDIR)/ipfs/build.sh >/dev/null

tor: build
	@echo 'building tor'; echo ''
	@BUILD=$(build)/user $(CURDIR)/tor/build.sh >/dev/null

varnish: build
	@echo 'building varnish'; echo ''
	@BUILD=$(build)/user $(CURDIR)/varnish/build.sh >/dev/null

exec:
	for i in $$(find $(CURDIR) -type f | grep 'docker-entrypoint\.sh\|setup\.sh'); do chmod +x $$i; done

debug-config:
	podman inspect -t image localhost/$(img) | jq --raw-output '.[0].Config'

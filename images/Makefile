SHELL=/bin/bash
build=$(CURDIR)/build

.PHONY: nginx ipfs tor

all: exec nginx ipfs tor

build:
	if [ ! -d $(build) ]; then mkdir $(build); fi

nginx: build
	BUILD=$(build) $(CURDIR)/nginx/build.sh

ipfs: build
	BUILD=$(build) $(CURDIR)/ipfs/build.sh

tor: build
	BUILD=$(build) $(CURDIR)/tor/build.sh

exec:
	for i in $(find $(CURDIR) -type f | grep 'docker-entrypoint\.sh|setup\.sh'); do chmod +x $i; done

debug-config:
	podman inspect -t image localhost/$(img) | jq --raw-output '.[0].Config'

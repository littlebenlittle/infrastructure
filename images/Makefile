SHELL=/bin/bash

.PHONY: ngnix ipfs tor

all: nginx ipfs tor

nginx:
	$(CURDIR)/build.sh docker.io/library/nginx:alpine localhost/nginx ./nginx

ipfs:
	$(CURDIR)/build.sh alpine:3.13 localhost/ipfs ./ipfs

tor:
	$(CURDIR)/build.sh alpine:3.13 localhost/tor ./tor

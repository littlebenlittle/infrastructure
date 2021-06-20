SHELL=/bin/bash

.PHONY: user root

all: user root

build-target:
	@if [ -z "$(build)" ]; then echo 'please set `build`'; exit 1; fi

user: build-target
	@echo 'building nginx for user'; echo ''
	@BUILD=$(build) RUNAS=user $(CURDIR)/build.sh >/dev/null

root: build-target
	@echo 'building nginx for root'; echo ''
	@BUILD=$(build) RUNAS=root $(CURDIR)/build.sh >/dev/null

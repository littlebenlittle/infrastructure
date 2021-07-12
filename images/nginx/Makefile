SHELL=/bin/bash

.PHONY: user root

build-target:
	@if [ -z "$(build)" ]; then echo 'please set `build`'; exit 1; fi

user: build-target
	@echo 'building nginx for user'; echo ''
	@BUILD=$(build) $(CURDIR)/build.sh user >/dev/null

root: build-target
	@echo 'building nginx for root'; echo ''
	@BUILD=$(build) $(CURDIR)/build.sh root >/dev/null

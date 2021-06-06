#!/bin/bash

set -e

if [ -z "$BUILD" ]; then echo "set BUILD" exit 1; fi
dir=${1:-`dirname $0`}

base=varnish
image=localhost/varnish

ctr=$(buildah from $base)
buildah add $ctr $dir/varnish.vcl /etc/varnish/varnish.vcl

buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$BUILD/$(echo $image | cut -d / -f 2)

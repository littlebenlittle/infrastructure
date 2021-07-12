#!/bin/bash

set -e

if [ -z "$BUILD" ]; then echo "set BUILD" exit 1; fi
dir=${1:-`dirname $0`}

base=docker.io/certbot/certbot
image=localhost/certbot

ctr=$(buildah from $base)
buildah add $ctr $dir/docker-entrypoint.sh /docker-entrypoint.sh
buildah run $ctr adduser -D -H -u 101 nginx 

buildah config --entrypoint '[ "/docker-entrypoint.sh" ]' $ctr

buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$BUILD/$(echo $image | cut -d / -f 2)

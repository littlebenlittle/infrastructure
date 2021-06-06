#!/bin/bash

set -e

if [ -z "$BUILD" ]; then echo "set BUILD" exit 1; fi
dir=${1:-`dirname $0`}

base=nginx:alpine
image=localhost/nginx

ctr=$(buildah from $base)
for i in nginx ssl_params cache_options; do
    buildah add $ctr $dir/$i.conf /etc/nginx/$i.conf
done

buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$BUILD/$(echo $image | cut -d / -f 2)

#!/bin/bash

set -e

if [ -z "$BUILD" ]; then echo "set BUILD" exit 1; fi
if [ -z "$RUNAS" ]; then echo "set RUNAS" exit 1; fi

dir=${1:-`dirname $0`}

base=nginx:alpine

ctr=$(buildah from $base)
image=localhost/nginx-$RUNAS
for i in `find $dir/$RUNAS -type f | grep -v 'build\.sh'`; do
	buildah add $ctr $i /etc/nginx/
done
for i in `find $dir/common -type f`; do
	buildah add $ctr $i /etc/nginx/
done
buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$BUILD/nginx

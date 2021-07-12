#!/bin/bash

set -e

if [ -z "$BUILD" ]; then echo "set BUILD" exit 1; fi
if [ -z "$1" ]; then echo "usage: $0 <user|root>" exit 1; fi

dir=`dirname $0`

base=nginx:alpine
runas=$1
image=localhost/nginx-$runas

ctr=$(buildah from $base)
for i in `find $dir/$runas -type f | grep -v '.sh$'`; do
	buildah add $ctr $i /etc/nginx/
done
for i in `find $dir/$runas -type f | grep '\.sh$'`; do
	buildah add $ctr $i /docker-entrypoint.d/
done
for i in `find $dir/common -type f | grep '\.conf$'`; do
	buildah add $ctr $i /etc/nginx/
done

buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$BUILD/nginx

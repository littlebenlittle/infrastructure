#!/bin/bash

set -e

dir=$(realpath `dirname $0`)

echo $dir

if [ ! -z "$1" ]; then
    img=`podman pull oci-archive:$dir/$1`
    podman tag $img $1
    exit 0
fi

for i in `find $dir -type f | grep -v '\..*$'`; do
    img=`podman pull oci-archive:$i`
    podman tag $img `basename $i`
done

#!/bin/bash

set -e

dir=$(realpath `dirname $0`)

echo $dir

user=${1:-$USER}
img=$2

if [ ! -z "$img" ]; then
    img=`podman pull oci-archive:$dir/$user/$img`
    podman tag $img $user
    exit 0
fi

for i in `find $dir/$user -type f | grep -v '\..*$'`; do
    img=`podman pull oci-archive:$i`
    podman tag $img `basename $i`
done

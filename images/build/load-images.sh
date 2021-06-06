#!/bin/bash

set -e

dir=${1:-`dirname $0`}

for i in `find $dir -type f | grep -v '\..*$'`; do
    img=`podman pull oci-archive:$i`
    podman tag $img `basename $i`
done

#!/bin/bash

set -e

base=$1
image=$2
setup=$3

ctr=$(buildah from $base)
buildah add $ctr $setup /SETUP
buildah run $ctr ash -c 'cd /SETUP; ./setup.sh'

buildah config \
    --entrypoint /bin/ash \
    --cmd /docker-entrypoint.sh \
    $ctr

buildah commit $ctr $image
buildah rm $ctr

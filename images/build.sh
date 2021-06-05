#!/bin/bash

set -e

base=$1
image=$2
setup=$3
build=${4:-./build}

if [ ! -d $build ]; then mkdir $build; fi

ctr=$(buildah from $base)
buildah add $ctr $setup /SETUP
buildah run $ctr ash -c 'cd /SETUP; ./setup.sh'

buildah config \
    --entrypoint /bin/ash \
    --cmd /docker-entrypoint.sh \
    $ctr

buildah commit $ctr $image
buildah rm $ctr

podman push $image oci-archive:$build/$(echo $image | cut -d / -f 2)

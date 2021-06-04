#!/bin/ash

set -e

apk add go-ipfs

cp ./docker-entrypoint.sh /docker-entrypoint.sh

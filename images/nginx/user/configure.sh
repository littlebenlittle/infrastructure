#!/bin/ash

set -ex

if [ -z "$IPFS_CID" ]; then echo 'please set IPFS_CID'; fail=1; fi
if [ -z "$PORT" ]; then echo 'please set PORT'; fail=1; fi
if [ ! -z "$fail" ]; then echo 'exiting due to above errors'; exit 1; fi

sed -i -e "s|IPFS_CID|$IPFS_CID|" /etc/nginx/nginx.conf
sed -i -e "s|PORT|$PORT|" /etc/nginx/nginx.conf

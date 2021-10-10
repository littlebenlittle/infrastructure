#!/bin/ash

if [ -z "$IPFS_CID" ]; then echo 'please set IPFS_CID'; exit 1; fi

sed -i -e "s/IPFS_CID/$IPFS_CID/" /etc/nginx/nginx.conf

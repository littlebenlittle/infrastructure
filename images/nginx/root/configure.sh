#!/bin/ash

set -ex

case "$PROTO" in
"http")
	sed -i -e "s/# SERVER/include http.conf;/" /etc/nginx/nginx.conf;
	;;
"https")
	if [ -z "$IPFS_CID" ]; then echo 'please set IPFS_CID'; fail=1; fi
	if [ -z "$IPFS_GATEWAY" ]; then echo 'please set IPFS_GATEWAY'; fail=1; fi
	if [ ! -z "$fail" ]; then exit 1; fi
	sed -i -e "s|IPFS_CID|$IPFS_CID|" /etc/nginx/https.conf
	sed -i -e "s|IPFS_GATEWAY|$IPFS_GATEWAY|" /etc/nginx/https.conf
	sed -i -e "s/# SERVER/include https.conf;/" /etc/nginx/nginx.conf;
	;;
*)
	echo 'please set PROTO=(http|https)';
	fail=1
	if [ ! -z "$fail" ]; then exit 1; fi
	;;
esac




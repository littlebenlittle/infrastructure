#!/bin/bash

pod=`podman pod create --name web -p 8000:80 -p 8080:8080 -p 4001:4001 -p 5001:5001`
	
options="-d --restart always --pod $pod"

podman run $options --name varnish \
	-e UPSTREAM=localhost:8080 \
	-e BIND_ADDR=localhost:8000 \
	localhost/varnish

podman run $options --name tor \
	-v tor_data:/var/lib/tor \
	-e UPSTREAM=localhost:80 \
	localhost/tor

podman run $options --name ipfs \
	-v ipfs_data:/data/ipfs \
	-e IPFS_PATH=/data/ipfs \
	localhost/ipfs

podman run $options --name nginx \
	localhost/nginx-user

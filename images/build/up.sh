#!/bin/bash

set -x

if [ `whoami` == user ]; then
	podman pod ls | grep web >/dev/null
	if [ $? == 0 ]; then podman pod stop web; podman pod rm web; fi
	podman pod create --name web -p 8000:80 -p 8080:8080 -p 4001:4001 -p 5001:5001
	podman run -d --restart always --pod web --name varnish \
		-e UPSTREAM=127.0.0.1:8080 \
		-e BIND_ADDR=127.0.0.1:8000 \
		localhost/varnish
	# podman run -d --restart always --pod web --name tor \
	# 	-v tor_data:/var/lib/tor \
	# 	-e UPSTREAM=127.0.0.1:80 \
	# 	localhost/tor
	podman run -d --restart always --pod web --name ipfs \
		-v ipfs_data:/data/ipfs \
		-e IPFS_PATH=/data/ipfs \
		localhost/ipfs
	podman run -d --restart always --pod web --name nginx \
		-v /opt/nginx:/opt/nginx \
		localhost/nginx

elif [ `whoami` == root ]; then
	podman pod ls | grep web >/dev/null
	if [ $? != 0 ]; then podman pod create --name web -p 80:80 -p 443:443; fi
	for vol in letsencrypt public; do
		podman volume ls | grep $vol >/dev/null
		if [ $? != 0 ]; then podman volume create $vol; fi
	done
	podman run -d --restart always --pod web --name nginx-http \
		-e PROTO=http \
		-v public:/var/www \
		localhost/nginx
	podman run -d --restart always --pod web --name nginx-https \
		-v /opt/nginx:/opt/nginx \
		-v letsencrypt:/etc/letsencrypt \
		-e PROTO=https \
		localhost/nginx
	podman run -d --restart always --pod web --name certbot \
		-e DOMAINS=benlittledev.com \
		-e EMAIL=ben.little@benlittle.dev \
		-v public:/var/www \
		-v letsencrypt:/etc/letsencrypt \
		localhost/certbot

else
	echo 'run as user or root!'
	exit 1
fi

#!/bin/bash

set -e

podman pod create --name web -p 80:80 -p 443:443
	
podman run -d --restart always --pod web --name nginx \
	-v /opt/nginx:/opt/nginx \
	-v /var/www:/var/www \
	-v /etc/letsencrypt:/etc/letsencrypt \
	localhost/nginx-root

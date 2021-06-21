#!/bin/ash

case "$PROTO" in
"http") sed -i -e "s/# SERVER/include http.conf;/" /etc/nginx/nginx.conf
	;;
"https") sed -i -e "s/# SERVER/include https.conf;/" /etc/nginx/nginx.conf
	;;
*) echo 'please set PROTO (=<http|https>)'; exit 1;
	;;
esac

chown -R nginx /var/www
chgrp -R nginx /var/www
chown -R nginx /etc/letsencrypt
chgrp -R nginx /etc/letsencrypt

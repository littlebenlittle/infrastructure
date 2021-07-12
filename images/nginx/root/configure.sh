#!/bin/ash

case "$PROTO" in
"http") sed -i -e "s/# SERVER/include http.conf;/" /etc/nginx/nginx.conf
	;;
"https") sed -i -e "s/# SERVER/include https.conf;/" /etc/nginx/nginx.conf
	;;
*) echo 'please set PROTO (=<http|https>)'; exit 1;
	;;
esac

for i in /var/www /etc/letsencrypt; do
	if [ -d $i ]; then
		chown -R nginx $i
		chgrp -R nginx $i
	fi
done

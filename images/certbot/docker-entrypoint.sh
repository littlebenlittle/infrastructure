#!/bin/ash

set -e
set -x

if [ -z "$DOMAINS" ]; then echo "please set DOMAINS (=example.com,examplecom.net)"; fail=1; fi
if [ -z "$EMAIL"   ]; then echo "please set EMAIL   (=user@example.com)";           fail=1; fi

target=/var/www
if [ ! -d $target ]; then echo "please mount $target"; fail=1; fi

if [ ! -z "$fail" ]; then exit 1; fi

if [ ! -d $target/acme-challenge ]; then mkdir $target/acme-challenge; fi

if [ ! -d /etc/letsencrypt/keys ]; then
	if [ ! -d /home/nginx ]; then mkdir /home/nginx; fi
	chown nginx /home/nginx
	chgrp nginx /home/nginx
	options="-n --agree-tos --webroot -d $DOMAINS --email $EMAIL --webroot-path $target --work-dir ~ --logs-dir ~"
	if [ -z "$TEST" ]
		then su nginx -c "certbot certonly $options"
		else su nginx -c "certbot certonly --test-cert $options"
	fi
fi

mkdir /etc/crond
target=/etc/crond/cron.00 
cat >$target <<EOM
${CRON:-0 0 6 * *} /usr/local/bin/certbot	su nginx -c 'sleep \$(python -c "import random; print(random.randint(0,3600))"); certbot renew -q'
EOM

echo "contents of $target:"
echo ''
cat $target | sed 's/^/    /'
echo ''

crond -f -c /etc/crond

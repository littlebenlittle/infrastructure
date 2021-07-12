#!/bin/ash
set -e

conf=/etc/varnish/default.vcl

host=`echo $UPSTREAM | cut -d : -f 1`
port=`echo $UPSTREAM | cut -d : -f 2`
cat >$conf <<EOF
vcl 4.0;
backend default {
  .host = "$host";
  .port = "$port";
}
EOF

echo "contents of $conf:"
echo ''
cat $conf | sed 's/^/    /'
echo ''

varnishd -F \
	-a localhost:8000 \
	-f $conf \
	-s malloc,${VARNISH_SIZE:-'100M'}

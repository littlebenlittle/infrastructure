#!/bin/ash

set -e

cat >/etc/tor/torrc <<EOM
HiddenServiceDir ${HIDDEN_SERVICE_DIR:-/var/lib/tor/svc}
HiddenServiceVersion 3
HiddenServicePort ${TOR_PORT:-5000} ${UPSTREAM:-localhost:8080}
EOM

echo 'contents of /etc/tor/torrc:'
echo ''
cat /etc/tor/torrc | sed 's/^/    /'
echo ''
 
chmod 600 /etc/tor/torrc
tor -f /etc/tor/torrc

#!/bin/ash

apk add tor

cp ./torrc /etc/tor/torrc
cp ./docker-entrypoint.sh /docker-entrypoint.sh

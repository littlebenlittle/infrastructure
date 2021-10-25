#!/bin/ash

set -e

if [ -z "$PORT" ]; then echo 'please set PORT'; fail=1; fi
if [ -z "$GATEWAY_PORT" ]; then echo 'please set GATEWAY_PORT'; fail=1; fi
if [ ! -f "$IPFS_PATH/config" ]; then ipfs init --profile server; fi

# TODO: use env vars
ipfs config Addresses.API /ip4/0.0.0.0/tcp/$PORT/
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/$GATEWAY_PORT/

ipfs daemon

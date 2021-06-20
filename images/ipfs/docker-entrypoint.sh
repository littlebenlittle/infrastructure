#!/bin/ash

set -e

if [ ! -f "$IPFS_PATH/config" ]; then ipfs init --profile server; fi

# TODO: use env vars
ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001/
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8001/

ipfs daemon

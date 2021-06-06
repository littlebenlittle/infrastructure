#!/bin/ash

set -e

ipfs init --profile server
ipfs daemon

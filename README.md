
# Infrastructure

A somewhat opinionated setup for serving IPFS content.

## Typical build

Local

```sh
REMOTE_DIR=user@123.45.67.89:/home/user
make images
make package
```

Remote

```sh
/home/user/build/load.sh
/home/user/build/up.sh
su -c /home/user/build/load.sh
su -c /home/user/build/up.sh
```

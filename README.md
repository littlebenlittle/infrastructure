
# Infrastructure

A somewhat opinionated setup for serving IPFS content.

## Typical build

First deploy an instance using [`linode/stackscript.sh`](linode/stackscript.sh).

`ssh` into the instance's root account and run `/root/setup.sh` to configure the instance.

### Local

```sh
REMOTE_DIR=user@123.45.67.89:/home/user
make images
make package
```

### Remote

```sh
mkdir /opt/nginx
chown user /opt/nginx
chgrp user /opt/nginx
/home/user/build/load.sh
/home/user/build/up.sh
su -c /home/user/build/load.sh
su -c /home/user/build/up.sh
```

## Managing Content

This setup uses IPFS for data management.

Upload data over `ssh`:

```sh
ssh -L '127.0.0.1:5000:127.0.0.1:5001' -L '127.0.0.1:8080:127.0.0.1:8080' $REMOTE_USER
```

Then open your browser to https://127.0.0.1:5000 to access the IPFS interface.

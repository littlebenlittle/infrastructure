#!/bin/bash

dnf -y upgrade
dnf -y install mosh iptables-services
systemctl disable firewalld
systemctl enable iptables
systemctl enable ip6tables

dnf remove firewalld

# ip4
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp -m multiport -m state --destination-ports 22,53,80,443   --state NEW -j ACCEPT
iptables -A INPUT -p udp -m multiport -m state --destination-ports 53,60000:60100 --state NEW -j ACCEPT
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables_INPUT_denied: " --log-level 7
iptables -A FORWARD -m limit --limit 5/min -j LOG --log-prefix "iptables_FORWARD_denied: " --log-level 7

iptables -P INPUT DROP
iptables -P FORWARD DROP

# ip6
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT DROP

hostnamectl set-hostname "podman-host-$LINODE_DATACENTERID-$LINODE_ID"
useradd -m user
usermod -aG wheel user

cat >/root/setup.sh <<EOF
#!/bin/bash

passwd user

sed -i \
    -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' \
    -e 's/PermitRootLogin yes/PermitRootLogin no/g' \
    -e 's/#AddressFamily any/AddressFamily inet/g' \
    /etc/ssh/sshd_config

systemctl restart sshd
EOF
chmod +x /root/setup.sh

# TODO
# load ssh keys from somewhere and put them in /home/user/.ssh/auorized_keys

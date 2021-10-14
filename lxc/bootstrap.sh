#!/bin/bash

# This script has been tested on Ubuntu 21.04
# For other versions of Ubuntu, you might need some tweaking
echo "[TASK 1] update permission of ssh"
chmod 600 /root/.ssh/authorized_keys && sudo chown root: /root/.ssh/authorized_keys

echo "[TASK 2] updating os"
apt update -qq >/dev/null 2>&1

echo "[TASK 3] installing resolveconf & configure"
apt install resolvconf -y -qq >/dev/null 2>&1

cat >>/etc/resolvconf/resolv.conf.d/head<<EOF
nameserver 1.1.1.1
EOF

echo "[TASK 4] swap off"
swapoff -a;

echo "[TASK 5] Hack required to provision K8s v1.15+ in LXC containers"
echo 'L /dev/kmsg - - - - /dev/console' > /etc/tmpfiles.d/kmsg.conf

mknod /dev/kmsg c 1 11
echo 'mknod /dev/kmsg c 1 11' >> /etc/rc.local
chmod +x /etc/rc.local

echo "[TASK 6] Install Karnel"

sudo apt install linux-generic -y -qq >/dev/null 2>&1;
sudo apt install --reinstall linux-image-$(uname -r) -y -qq >/dev/null 2>&1;
sudo apt install --reinstall linux-modules-$(uname -r) -y -qq >/dev/null 2>&1;
sudo apt install --reinstall linux-modules-extra-$(uname -r) -y -qq >/dev/null 2>&1;

echo "[TASK 7] Install NFS server common file"
sudo apt install nfs-common -y -qq >/dev/null 2>&1;

echo "########Completed All Task########"





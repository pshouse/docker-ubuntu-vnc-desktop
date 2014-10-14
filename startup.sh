#!/bin/bash

mkdir /var/run/sshd

# create an ubuntu user
PASS=`pwgen -c -n -1 10`
PASS=ubuntu
echo "User: ubuntu Pass: $PASS"
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ubuntu
echo "ubuntu:$PASS" | chpasswd

cp -a /Squeak-4.5-All-In-One/Squeak-4.5-All-in-One.app /home/ubuntu

/usr/bin/supervisord -c /supervisord.conf

while [ 1 ]; do
    /bin/bash
done

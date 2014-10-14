#!/bin/bash

mkdir /run/sshd

# create an ubuntu user
PASS=`pwgen -c -n -1 10`
PASS=ubuntu
echo "User: ubuntu Pass: $PASS"
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ubuntu
echo "ubuntu:$PASS" | chpasswd

# Copy Squeak files
cp -a /Squeak-4.5-All-In-One/Squeak-4.5-All-in-One.app /home/ubuntu
cp /Squeak-4.5-All-In-One/squeak.sh /home/ubuntu

# Set Owner
chown -R ubuntu:ubuntu /home/ubuntu/Squeak-4.5-All-in-One.app

# Start process supervisor
/usr/bin/supervisord -c /supervisord.conf

while [ 1 ]; do
    /bin/bash
done

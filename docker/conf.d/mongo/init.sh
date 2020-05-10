#!/bin/#!/bin/sh
apt update && apt install -y wget yum net-tools
cd /root
wget https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian10-v2.13.4.tgz
tar -xvzf mongodb-bi-linux-x86_64-debian10-v2.13.4.tgz

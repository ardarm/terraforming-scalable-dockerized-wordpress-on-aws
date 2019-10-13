#!/bin/bash -xe
apt-get -y update
apt-get -y install unattended-upgrades
sudo apt-get -y install nfs-common
mkdir /efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efsid}.efs.ap-southeast-1.amazonaws.com:/ /efs
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo docker run -d -e WORDPRESS_DB_HOST=${dbhost}:3306 -e WORDPRESS_DB_PASSWORD=wpdbwpdb -e WORDPRESS_DB_USER=wpdb -e WORDPRESS_DB_NAME=wpdb  -v /efs/wordpress:/var/www/html -p 80:80 wordpress:latest

apt-get -y update
apt-get -y install unattended-upgrades
apt-get -y install nfs-common 
mkdir /efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efsid}.efs.ap-southeast-1.amazonaws.com:/ /efs
curl 'https://bootstrap.pypa.io/get-pip.py' -o 'get-pip.py'
python get-pip.py
pip install awscli
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-key fingerprint 0EBFCD88
apt-get -y update
apt-get -y install docker-ce
apt-get -y install fail2ban
pip install docker-compose
docker run -d -e WORDPRESS_DB_HOST=${dbhost}:3306 -e WORDPRESS_DB_PASSWORD=godblessuallthetime -e WORDPRESS_DB_USER=wpdb -e WORDPRESS_DB_NAME=wpdb -p 80:80 wordpress:latest

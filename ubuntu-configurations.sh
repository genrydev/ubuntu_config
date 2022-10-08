#!/bin/bash

echo "Running apt update"
apt update && apt dist-upgrade -y

echo "Install MySQL Server 5.7.29"
apt install -y libtinfo5 libmecab2

mkdir mysql && cd mysql

wget https://downloads.mysql.com/archives/get/p/23/file/mysql-client_5.7.29-1ubuntu18.04_amd64.deb
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-common_5.7.29-1ubuntu18.04_amd64.deb
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client_5.7.29-1ubuntu18.04_amd64.deb
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-server_5.7.29-1ubuntu18.04_amd64.deb
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_5.7.29-1ubuntu18.04_amd64.deb
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_5.7.29-1ubuntu18.04_amd64.deb-bundle.tar
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-testsuite_5.7.29-1ubuntu18.04_amd64.deb

dpkg -i ./mysql-common_5.7.29-1ubuntu18.04_amd64.deb
dpkg -i ./mysql-community-client_5.7.29-1ubuntu18.04_amd64.deb
dpkg -i ./mysql-client_5.7.29-1ubuntu18.04_amd64.deb
dpkg -i ./mysql-community-server_5.7.29-1ubuntu18.04_amd64.deb
dpkg -i ./mysql-server_5.7.29-1ubuntu18.04_amd64.deb

echo "Install Apache Server 2.0"
DEBIAN_FRONTEND=noninteractive apt install -y apache2

a2dismod mpm_event
a2enmod mpm_prefork

systemctl restart apache2

echo "Install PHP 7.4 & PHP Extensions"
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common
add-apt-repository -y ppa:ondrej/php
apt update
DEBIAN_FRONTEND=noninteractive apt install -y php7.4
DEBIAN_FRONTEND=noninteractive apt install -y php7.4-mysql php7.4-xml php7.4-curl php7.4-mbstring php7.4-gd

echo "Install PHP Composer"
DEBIAN_FRONTEND=noninteractive apt install -y php7.4-cli
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

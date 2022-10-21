#!/bin/bash

BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}-= Configuring VARs for non interactive dialogs =-${NC}"

export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive

echo -e "${BLUE}-= Updating Debian =-${NC}"

apt update && apt dist-upgrade -y

echo -e "${BLUE}-= Installing Apache Server 2.0 =-${NC}"

apt install -y apache2
a2dismod mpm_event
a2enmod mpm_prefork
systemctl restart apache2
systemctl enable apache2

echo -e "${BLUE}-= Installing PHP 7.4 & PHP Extensions =-${NC}"

apt install -y php7.4
apt install -y php7.4-mysql php7.4-xml php7.4-curl php7.4-mbstring php7.4-gd

echo -e "${BLUE}-= Installing PHP Composer =-${NC}"

apt install -y php7.4-cli
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo -e "${BLUE}-= Installing Docker =-${NC}"

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker azureuser

echo -e "${BLUE}-= Doing Other Tasks =-${NC}"

echo -e "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php
echo -e "host  all  all  0.0.0.0/0  md5" >> /etc/postgresql/13/main/pg_hba.conf
echo -e "host  all  all  ::/0  md5" >> /etc/postgresql/13/main/pg_hba.conf
sed -i '/listen_addresses/s/^#//g' /etc/postgresql/13/main/postgresql.conf
sed -i '/listen_addresses/s/localhost/\*/g' /etc/postgresql/13/main/postgresql.conf
systemctl restart postgresql
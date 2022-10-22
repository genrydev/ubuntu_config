#!/bin/bash

echo -e "${BLUE}-= Installing GIT =-${NC}"

apt install -y git

echo -e "${BLUE}-= Installing Docker =-${NC}"

curl -fsSL https://get.docker.com -o get-docker.sh ; sh get-docker.sh ; usermod -aG docker azureuser

echo -e "${BLUE}-= Doing Other Tasks =-${NC}"

echo -e "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

docker run -d \
--name bhudb \
-e POSTGRES_USER=drupal \
-e POSTGRES_PASSWORD=drupal \
-e POSTGRES_DB=drupal \
-e PGDATA=/var/lib/postgresql/data/pgdata \
-v /opt/drupaldb:/var/lib/postgresql/data \
-v /opt/backups:/backups \
-p 5432:5432 \
--restart unless-stopped \
postgres:13.8
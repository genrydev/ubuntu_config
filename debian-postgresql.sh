#!/bin/bash

##########################################################################################
# Este script permite configurar un SO Debian 11 para el despliegue de PostgreSQL        #
#                                                                                        #
# Algunas consideraciones:                                                               #
# - El script deberá ser ejecutado con permisos de super-usuario (root)                  #
# - Debe existir acceso a internet de manera directa, sin necesidad de uso de proxy      #
# - El script logue la mínima información (warnings o errores)                           #
#                                                                                        #
# Ejecución:                                                                             #
# $ sudo su                                                                              #
# # bash debian-postgresql.sh                                                            #
##########################################################################################

BLUE='\033[0;34m'
NC='\033[0m'

POSTGRESQL_PORT=2345

echo -e "${BLUE}-= Configuring VARs for non interactive dialogs =-${NC}"

export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive

echo -e "${BLUE}-= Updating Debian =-${NC}"

apt-get -qq update && apt-get -qq dist-upgrade -y

echo -e "${BLUE}-= Installing PostgreSQL 13.8 =-${NC}"

apt-get -qq install -y postgresql

echo -e "${BLUE}-= Change PostgreSQL default port & listen addresses =-${NC}"

sed -i "s/5432/$POSTGRESQL_PORT/g" /etc/postgresql/13/main/postgresql.conf
sed -i '/listen_addresses/s/localhost/*/g' /etc/postgresql/13/main/postgresql.conf
sed -i '/listen_addresses/s/^#//g' /etc/postgresql/13/main/postgresql.conf

echo -e "host all all 0.0.0.0/0 md5" >> /etc/postgresql/13/main/pg_hba.conf

echo -e "${BLUE}-= Restarting PostgreSQL service =-${NC}"

systemctl restart postgresql
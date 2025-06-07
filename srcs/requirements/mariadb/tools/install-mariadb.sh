#!/bin/bash

# Configuration of MariaDB to listen on every interfaces
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Starting MariaDB
service mysql start

# Data base configuration
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Stopping the service for a better restart
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

# Start MariaDB in safe mode (for Docker)
exec mysqld_safe --bind-address=0.0.0.0

#!/bin/bash


set -e

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
  echo "Database initialization..."

  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  mysqld_safe --skip-networking &
  pid="$!"

  echo "Waiting for mysqld..."
  until mysqladmin ping --silent; do
    sleep 1
  done

  echo "MariaDB configuration..."

  mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

  echo "Temporary stop of mysqld..."
  mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

  echo "MariaDB initialized."
else
  echo "Base already initialized, normal startup."
fi

# Launch mysql (process PID 1)
exec mysqld_safe

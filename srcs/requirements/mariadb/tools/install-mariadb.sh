#!/bin/bash


set -e

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
  echo "Initialisation de la base de données..."

  # Initialiser la base si vide
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  # Lancer mysqld en arrière-plan sans réseau pour init
  mysqld_safe --skip-networking &
  pid="$!"

  echo "En attente de mysqld..."
  until mysqladmin ping --silent; do
    sleep 1
  done

  echo "Configuration de MariaDB..."

  mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
  mariadb -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

  echo "Arrêt temporaire de mysqld..."
  mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

  echo "✅ MariaDB initialisée."
else
  echo "✅ Base déjà initialisée, démarrage normal."
fi

# Lancer mysqld pour de bon (process PID 1)
exec mysqld_safe

# if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
# 	echo "Initialisation de la base de données..."

# 	# Démarrage temporaire du service MariaDB
# 	service mariadb start

# 	# Sécurisation de MariaDB + création de la base et des utilisateurs
# 	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
# 	mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
# 	mariadb -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
# 	mariadb -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
# 	mariadb -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# 	# Arrêt propre
# 	service mariadb stop
# fi

# # Lancer mysqld (pas via service car CMD attend un process PID 1)
# exec mysqld_safe

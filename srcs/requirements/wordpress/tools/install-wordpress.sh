#!/bin/bash

# # Configuration of PHP-FPM to listen on every interfaces
# sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
# sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf
# sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf

# # Download WordPress
# cd /var/www
# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# rm latest.tar.gz

# # Permissions configuration
# chown -R www-data:www-data /var/www/wordpress
# chmod -R 755 /var/www/wordpress

# # WordPress configuration
# cd /var/www/wordpress
# cp wp-config-sample.php wp-config.php

# # Replace configuration variables
# sed -i "s/${DB_NAME}/g" wp-config.php
# sed -i "s/${DB_USER}/g" wp-config.php
# sed -i "s/${DB_PASSWORD}/g" wp-config.php
# sed -i "s/${DB_HOST}/g" wp-config.php

# # Install WP-CLI for auto configuration
# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp

# # Wait MariaDB
# until wp db check --allow-root --path=/var/www/wordpress; do
#     echo "En attente de la base de données..."
#     sleep 5
# done

# # Install WordPress with WP-CLI
# wp core install \
#     --url=${DOMAIN_NAME} \
#     --title="Inception WordPress" \
#     --admin_user=${WP_ADMIN_USER} \
#     --admin_password=${WP_ADMIN_PASSWORD} \
#     --admin_email=${WP_ADMIN_EMAIL} \
#     --allow-root \
#     --path=/var/www/wordpress

# # Creation of another user
# wp user create ${WP_USER} ${WP_USER_EMAIL} \
#     --user_pass=${WP_USER_PASSWORD} \
#     --role=author \
#     --allow-root \
#     --path=/var/www/wordpress

# # Starting PHP-FPM
# mkdir -p /run/php
# exec php-fpm7.4 -F



# Configuration de PHP-FPM pour écouter sur toutes les interfaces
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.owner = www-data|listen.owner = www-data|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.group = www-data|listen.group = www-data|' /etc/php/7.4/fpm/pool.d/www.conf

# Téléchargement de WordPress
cd /var/www
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm latest.tar.gz

# Droits d'accès
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Configuration de WordPress
cd /var/www/wordpress
cp wp-config-sample.php wp-config.php

# Remplacement des valeurs dans wp-config.php
sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sed -i "s/username_here/${DB_USER}/" wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" wp-config.php
sed -i "s/localhost/${DB_HOST}/" wp-config.php

# Installation de WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Attente que la base de données soit disponible
until wp db check --allow-root --path=/var/www/wordpress  --host=${DB_HOST} --user=${DB_USER} --pass=${DB_PASSWORD}; do
    echo "En attente de la base de données..."
    sleep 5
done

# Installation de WordPress
wp core install \
    --url="${DOMAIN_NAME}" \
    --title="Inception WordPress" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root \
    --path=/var/www/wordpress

# Création d'un utilisateur
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=author \
    --allow-root \
    --path=/var/www/wordpress

# Démarrage de PHP-FPM
mkdir -p /run/php
exec php-fpm7.4 -F
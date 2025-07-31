#!/bin/bash

# PHP-FPM configuration to listen on all interfaces
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.owner = www-data|listen.owner = www-data|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.group = www-data|listen.group = www-data|' /etc/php/7.4/fpm/pool.d/www.conf

# Download WordPress
cd /var/www
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm latest.tar.gz

# Permissions
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# WordPress configuration
cd /var/www/wordpress
cp wp-config-sample.php wp-config.php

# Replacing values in wp-config.php
sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sed -i "s/username_here/${DB_USER}/" wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" wp-config.php
sed -i "s/localhost/${DB_HOST}/" wp-config.php

# Installing WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Waiting for the database to be available
until wp db check --allow-root --path=/var/www/wordpress  --host=${DB_HOST} --user=${DB_USER} --pass=${DB_PASSWORD}; do
    echo "En attente de la base de données..."
    sleep 5
done

# Installing WordPress
wp core install \
    --url="${DOMAIN_NAME}" \
    --title="Inception WordPress" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root \
    --path=/var/www/wordpress

# Creating a user
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=author \
    --allow-root \
    --path=/var/www/wordpress

# Starting PHP-FPM
mkdir -p /run/php
exec php-fpm7.4 -F

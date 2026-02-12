#!/bin/bash
set -e

cd /var/www/html

SQL_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

until mysqladmin ping -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' \
    /etc/php/8.2/fpm/pool.d/www.conf

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

    wp core download --allow-root

    wp config create --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306"

    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create --allow-root \
        "$WP_USER" "$WP_EMAIL" \
        --user_pass="$WP_USER_PASSWORD"

    chown -R www-data:www-data /var/www/html
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php

exec /usr/sbin/php-fpm8.2 -F

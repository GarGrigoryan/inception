#!/bin/bash
set -e

# Wait for MariaDB to be ready
sleep 10

# Read secrets
SQL_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    # Download WordPress
    wp core download --allow-root

    # Create config
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306

    # Install WordPress site
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    # Create a second user (non-admin) as required by the subject
    wp user create --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASSWORD
fi

# Ensure PHP-FPM directory exists for the PID
mkdir -p /run/php

# Start PHP-FPM in foreground
exec /usr/sbin/php-fpm7.4 -F
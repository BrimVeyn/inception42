#!/bin/bash

# Attendre que la base de données soit accessible
until mysql -h "mariadb" -u "$SQL_USER" -p"$SQL_PASSWORD" -e "show databases;" > /dev/null 2>&1; do
    echo "Waiting for database connection..."
    sleep 5
done

# Vérifiez si wp-cli est installé
if ! command -v wp &> /dev/null; then
    echo "wp-cli could not be found"
    exit 1
fi

# Créez le fichier wp-config.php si il n'existe pas
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp config create --allow-root \
                     --dbname="$SQL_DATABASE" \
                     --dbuser="$SQL_USER" \
                     --dbpass="$SQL_PASSWORD" \
                     --dbhost="mariadb:3306" \
                     --path="/var/www/wordpress" \
                     --skip-check
fi

# Installez WordPress si il n'est pas déjà installé
if ! wp core is-installed --allow-root --path="/var/www/wordpress"; then
    wp core install --allow-root --path="/var/www/wordpress" \
                    --url="https://bvan-pae.42.fr" \
                    --title="My WordPress Site" \
                    --admin_user="$ADMIN_USER" \
                    --admin_password="$ADMIN_PASSWORD" \
                    --admin_email="$ADMIN_EMAIL"
fi

# Créez le répertoire /run/php si il n'existe pas
mkdir -p /run/php
chown -R www-data:www-data /run/php

# Démarrez PHP-FPM
/usr/sbin/php-fpm7.4 -F

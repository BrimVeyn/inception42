# Using php:7.4-fpm directly might be more efficient, but if you need Debian Bullseye for other reasons:
FROM debian:bullseye

EXPOSE 9000

ARG SQL_DATABASE
ARG SQL_USER
ARG SQL_PASSWORD
ARG ADMIN_USER
ARG ADMIN_PASSWORD
ARG ADMIN_EMAIL

# Install PHP and necessary extensions along with utilities
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y php7.4 php7.4-fpm php7.4-mysql mariadb-client wget \
    && rm -rf /var/lib/apt/lists/*  # Cleanup apt cache to reduce image size

# Download and unpack WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.0-fr_FR.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# Change ownership of the WordPress files
RUN chown -R www-data:www-data /var/www/wordpress

# RUN ln -s $(which php-fpm7.4) /usr/sbin/php-fpm7.4


# Copy a custom PHP-FPM config file
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tool/auto-config.sh /

WORKDIR /var/www/wordpress
VOLUME /var/www/wordpress

# Confirm PHP-FPM is installed
RUN which php-fpm7.4 || echo "PHP-FPM not found"

RUN chmod +x /auto-config.sh

ENTRYPOINT ["/auto-config.sh"]

# # Using php:7.3-fpm directly might be more efficient, but if you need Debian Bullseye for other reasons:
# FROM debian:bullseye
# # Set environment variables
# EXPOSE 9000
#
# ENV SQL_DATABASE="datab" \
#     SQL_USER="bvan-pae" \
#     SQL_PASSWORD="inception" \
#     SQL_ROOT_PASSWORD="rinception"
# # Install PHP and necessary extensions along with utilities
#
# RUN apt-get update -y && apt-get upgrade -y \
#     && apt-get install -y php7.4 php-fpm php-mysql mariadb-client wget \
#     && rm -rf /var/lib/apt/lists/*  # Cleanup apt cache to reduce image size
#
# # Download and unpack WordPress
# RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
#     tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www && \
#     rm /var/www/wordpress-6.0-fr_FR.tar.gz
#
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/local/bin/wp
# # RUN ln -s $(which php-fpm7.4) /usr/sbin/php-fpm7.4
# # Change ownership of the WordPress files
# RUN chown -R www-data:www-data /var/www/wordpress
#
# # Copy a custom PHP-FPM config file
# COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# COPY tool/auto-config.sh /
#
# WORKDIR /var/www/wordpress
# VOLUME /var/www/wordpress
#
# # Confirm PHP-FPM is installed
# RUN which php-fpm7.4 || echo "PHP-FPM not found"
#
# RUN chmod +x /auto-config.sh
# ENTRYPOINT ["/auto-config.sh"]
# # Start PHP-FPM server
# # CMD ["/bin/bash", "/auto-config.sh" ]

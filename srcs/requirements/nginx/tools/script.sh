#!/bin/bash
echo "127.0.0.1 bvan-pae.42.fr" >> /etc/hosts
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Nginx: setting up ssl ..."
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=bvan-pae.42.fr/UID=bvan-pae"
    echo "Nginx: ssl is set up!"
fi
exec "$@"

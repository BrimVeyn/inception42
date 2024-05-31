FROM debian:bullseye
EXPOSE 443

# Install necessary packages and clean up in one layer to reduce image size
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl curl vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories and generate SSL certificates
RUN mkdir -p /etc/nginx/ssl /var/run/nginx && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=bvan-pae.42.fr/UID=bvan-pae"

# Copy custom nginx configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/script.sh /
# Fix permissions
# RUN chmod -R 755 /var/www/wordpress
# RUN chown -R www-data:www-data /var/www/wordpress
# VOLUME /var/www/wordpress 
# RUN echo "127.0.0.1 bvan-pae.42.fr" >> /etc/hosts

ENTRYPOINT ["/script.sh"]

CMD ["nginx", "-g", "daemon off;"]

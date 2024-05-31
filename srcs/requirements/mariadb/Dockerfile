FROM debian:bullseye

# Install MariaDB and required tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server vim

# Set up necessary directories and permissions
RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mariadb && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mariadb

# Initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy your configuration and script files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tool/launch_sql.sh /launch_sql.sh
RUN chmod 755 /launch_sql.sh

# Set environment variables
ARG SQL_DATABASE
ARG SQL_USER
ARG SQL_PASSWORD

# Set the command to run on container start
ENTRYPOINT ["bash", "/launch_sql.sh"]

# CMD ["mysqld"]

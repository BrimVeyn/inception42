# Start the MySQL service
mysqld_safe &
# Wait for MySQL to fully start
until mysqladmin ping >/dev/null 2>&1; do
    echo "Waiting for database connection..."
    sleep 2
done

# Create database and user if they do not exist
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shutdown MySQL to allow safe start with CMD
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MySQL in the foreground
exec mysqld_safe

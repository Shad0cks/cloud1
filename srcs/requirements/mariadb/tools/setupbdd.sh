#!/bin/bash

# Check if the directory /var/run/mysql exists
if [ -d "/var/run/mysql" ]; then
    # If it exists, create /var/run/mysqld, set owner to mysql:mysql, and set permissions to 770
    mkdir -p /var/run/mysqld
    chown -R mysql:mysql /var/run/mysqld
    chmod 770 /var/run/mysqld
fi

# Check if the SQL script exists and is readable
if [ ! -r "setupbdd.sql" ]; then
    # If it does not exist or is not readable, create a new one with SQL commands to create a database, user, and set root password
    cat << END > setupbdd.sql 
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$PASSWD';
GRANT ALL PRIVILEGES on $DATABASE_NAME.* TO '$MYSQL_USER'@'%';
ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$PASSWD';
FLUSH PRIVILEGES;
END
    # Start the MariaDB service
    service mysql start
    # Execute the SQL script using the mysql command
    mysql < setupbdd.sql
fi
# Start the MariaDB daemon with the data directory set to /var/lib/mysql
/usr/bin/mysqld_safe --datadir=/var/lib/mysql

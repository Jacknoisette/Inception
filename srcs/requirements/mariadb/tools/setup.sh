#!/bin/sh


if [ ! -d "/var/lib/mysql/mysql"]; then
    echo "Starting MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
    mysqld_safe --datadir=/var/lib/mysql &

    sleep 5

    echo "Setting up initial database..."

    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    mysqladmin shutdown
fi

exec mysqld_safe --datadir=/var/lib/mysql


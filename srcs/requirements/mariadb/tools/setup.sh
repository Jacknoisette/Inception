#!/bin/sh

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
    mysqld_safe --datadir=/var/lib/mysql &

    echo "Waiting for MariaDB to start..."
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    echo "MariaDB started, running setup SQL..."

    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
fi

exec mysqld_safe --datadir=/var/lib/mysql


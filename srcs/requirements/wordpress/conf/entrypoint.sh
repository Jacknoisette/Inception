#!/bin/sh

until mysqladmin ping -h mariadb --silent; do
  echo "Waiting for mariadb…"
  sleep 1
done

wp config create	--allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb:3306 --path='/var/www/html'

wp core install \
  --url="$WP_URL" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASSWORD" \
  --admin_email="$WP_ADMIN_EMAIL" \
  --skip-email
wp user create \
  "$WP_USER" "$WP_USER_EMAIL" \
  --user_pass="$WP_USER_PASSWORD"

exec php-fpm7.3 -F

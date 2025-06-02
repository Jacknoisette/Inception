#!/bin/sh

until mysqladmin ping -h mariadb --silent; do
  echo "Waiting for mariadb…"
  sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Downloading WordPress..."
  wp core download --allow-root --path='/var/www/html'
  chown -R www-data:www-data /var/www/html
else
  echo "WordPress was already installed !"
fi

if ! wp core is-installed --path='/var/www/html' --allow-root; then
  wp config create	--allow-root \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/html' --allow-root


  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --path='/var/www/html' --allow-root

  echo "WordPress is install !"
fi

if ! wp user get "$WP_USER" --path='/var/www/html' --allow-root > /dev/null 2>&1; then
  wp user create \
    "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --path='/var/www/html' --allow-root
fi

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

exec php-fpm7.4 -F

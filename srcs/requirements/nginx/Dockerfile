FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt install php-fpm -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/jdhallen.42.fr.crt -keyout /etc/nginx/ssl/jdhallen.42.fr.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jdhallen.42.fr/UID=jdhallen.42.fr"

COPY conf/default.conf etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt-get -y install wget php php7.4-fpm php-mysqli php-redis mariadb-client && service php7.4-fpm start\
    && apt-get clean

RUN useradd -m -u 1000 www42

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www


RUN mkdir -p /var/www/html
RUN mv /var/www/wordpress-6.0-fr_FR.tar.gz /var/www/html/
RUN cd /var/www/html && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT /usr/local/bin/entrypoint.sh
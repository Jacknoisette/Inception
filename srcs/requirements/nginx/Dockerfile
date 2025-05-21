FROM debian:bullseye

RUN apt update -y
RUN apt install nginx -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=jdhallen.42.fr"


# COPY conf/default.conf etc/nginx/conf.d/default.conf
# COPY ssl/jdhallen.42.fr.crt /etc/ssl/certs/jdhallen.42.fr.crt
# COPY ssl/jdhallen.42.fr.key /etc/ssl/private/jdhallen.42.fr.key

# EXPOSE 443

# CMD ["nginx", "-g", "daemon off"]
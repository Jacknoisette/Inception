FROM debian:bullseye

RUN apt update && apt install -y mariadb-server
COPY tools/setup.sh /tools/setup.sh
ENTRYPOINT ["sh", "/tools/setup.sh"]
FROM debian:buster

RUN apt update && apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/mariaDB.conf	/etc/mysql/mariadb.conf.d/mariaDB.conf

COPY ./conf/mariaDB.sh .
RUN  chmod +x mariaDB.sh

EXPOSE 3306

CMD ["./mariaDB.sh"]
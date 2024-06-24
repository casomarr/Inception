FROM    debian:bullseye

RUN     apt update && apt upgrade -y
RUN     apt install mariadb-server -y

# COPY  conf/mariaDB.conf	    /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	conf/50-server.cnf	    /etc/mysql/mariadb.conf.d/50-server.cnf
# why COPY instead of RUN cp conf/50...

COPY    ./conf/mariaDB.sh       .
RUN     chmod +x mariaDB.sh

EXPOSE  3306

CMD     ["./mariaDB.sh"]
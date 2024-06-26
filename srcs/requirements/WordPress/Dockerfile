# WordPress dockerfile

FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install nginx -y

## Installation

# download wget
RUN apt-get -y install wget

# download PHP and its dependencies
RUN apt-get install -y php7.4\
						php-fpm\
						php-mysql\
						mariadb-client

# download WordPress
RUN wget https://fr.wordpress.org/wordpress-6.4-fr_FR.tar.gz -P /var/www

# we delete the .tar file
RUN cd /var/www && tar -xzf wordpress-6.4-fr_FR.tar.gz && rm wordpress-6.4-fr_FR.tar.gz

# We allow the root user to write in the wordpress folder
RUN cp -r /var/www/wordpress/. /var/www/html
RUN rm -rf /var/www/wordpress
RUN	chown -R root:root /var/www/html

## PHP Configuration

COPY ./conf/www.conf  /etc/php/7.4/fpm/pool.d/www.conf

## WordPress Configuration

# install CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# move to correct folder and give rights
RUN chmod +x wp-cli.phar

# move CLI script to container folder and give rights
COPY ./conf/cli_config.sh .
RUN chmod +x cli_config.sh

RUN mkdir -p /run/php

# set container's port
EXPOSE 9000

# run CLI script
CMD [ "./cli_config.sh"]


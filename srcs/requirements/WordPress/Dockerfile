# WordPress dockerfile

FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install nginx -y

## Installation

# download wget
RUN apt-get -y install wget

# download PHP and its dependencies
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client
                        #TODO : vérifier mariadb-client

# download WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# we delete the .tar file
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# We allow the root user to write in the wordpress folder
RUN	chown -R root:root /var/www/wordpress

## PHP Configuration

# COPY ./conf/wordpress.conf  /etc/php/7.4/fpm/pool.d/wordpress.conf
# COPY ./conf/wordpress.conf  /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wordpress.conf  /etc/php/7.4/fpm/pool.d/
# COPY ./conf/wordpress.conf .

## WordPress Configuration

# install CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# move to correct folder and give rights
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# move CLI script to container folder and give rights
COPY ./conf/cli_config.sh .
RUN chmod +x cli_config.sh

# set container's port
EXPOSE 9000

# run CLI script
CMD [ "./cli_config.sh"]


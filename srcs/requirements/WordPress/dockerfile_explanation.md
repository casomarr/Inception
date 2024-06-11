# WordPress dockerfile

FROM debian:buster

RUN apt update && apt upgrade -y
RUN apt install nginx -y

## Installation

Download wget : it will allow us to download WordPress

`RUN apt-get -y install wget`

Download PHP (and its dependencies php-fpm and php-mysql)

`RUN apt-get install -y php7.3 && php-fpm && php-mysql && mariadb-client`

Download WordPress by giving wget its link

`RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www`

- we indicate wget to download wordpress in the folder /var/www since
- we have indicated it was the primary folder to display in the NGINX container
- tar -xvf fileName : used to unzip the file

We delete the .tar file that will be no longer used

`RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz`

We allow the root user to write in the wordpress folder

`RUN		chown -R root:root /var/www/wordpress`

## PHP configuration

Most WordPress files are .php.
--> see conf/wordpress.conf

Move php configuration file to the container folder

`COPY ./conf/wordpress.conf  /etc/php/7.4/fpm/pool.d/wordpress.conf`


## WordPress configuration

### CLI

We install CLI using wget. CLI will allow us to automatically configure the configuration page of WordPress without having to configure ourselves a .php file.

`RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`

We give the rights and move it to the right folder

`RUN chmod +x wp-cli.phar`

`RUN mv wp-cli.phar /usr/local/bin/wp`

### script to use CLI : conf/cli_config.sh

Run CLI script to automatically configure the first two pages of WordPress.

`COPY ./conf/cli_config.sh .`

`RUN chmod +x cli_config.sh`

`EXPOSE 9000` --> Set container's port.

`CMD [ "./cli_config.sh"]`




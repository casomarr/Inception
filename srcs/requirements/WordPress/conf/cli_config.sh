#!/bin/bash

if [ -f /var/www/html/wordpress-config.php ]; then
	echo "Wordpress database already exists"

else

    sleep 15 # To ensure MariaDB's database has had the time to finish launching

    echo "Configurating wordpress"

    # To automatically enter the information in the first WordPress welcome page :
    ./wp-cli.phar config create	--allow-root \
                        --dbname=$SQL_DATABASE \
                        --dbuser=$SQL_USER \
                        --dbpass=$SQL_PASSWORD \
                        --dbhost=mariadb:3306 \
                        --path='/var/www/html'

    # To automatically configure the second page :
    ./wp-cli.phar core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path='/var/www/html'
    # Add user
    echo "Creating wordpress user"
    ./wp-cli.phar user create $USER $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --path='/var/www/html' --allow-root

fi

#creates /run/php if it doesn't already exist to avoid PHP error
exec /usr/sbin/php-fpm7.4 -F
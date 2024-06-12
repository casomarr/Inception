sleep 10 #to ensure MariaDB's database has had the time to finish launching

# To automatically enter the information in the first WordPress welcome page :
wp config create	--allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'

# To automatically configure the second page :
# Install WordPress
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=/var/www/html --allow-root
# Add user
wp user create $USER $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --path=/var/www/html --allow-root

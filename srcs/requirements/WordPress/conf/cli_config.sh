sleep 10 #to ensure MariaDB's database has had the time to finish launching

# To automatically enter the information in the first WordPress welcome page :
wp config create	--allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'

# To automatically configure the second page :
wp core install
wp user create
//A FAIRE
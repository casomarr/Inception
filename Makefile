SRCS = 	srcs/requirements/MariaDB/conf/50-server.cnf \
        srcs/requirements/MariaDB/conf/mariaDB.sh \
        srcs/requirements/MariaDB/Dockerfile \
        srcs/requirements/NGINX/conf/nginx.conf \
        srcs/requirements/NGINX/Dockerfile \
        srcs/requirements/WordPress/conf/cli_config.sh \
        srcs/requirements/WordPress/conf/www.conf \
        srcs/requirements/WordPress/Dockerfile \

all: ${SRCS} create_volumes_folders add_env_variables
# docker compose
		@echo "Building the containers."
		docker compose -f ./srcs/docker-compose.yml up -d --build

create_volumes_folders :
		@echo "Creating the volumes' folders."
		@if [ ! -d /home/casomarr/data/ ]; \
		then \
			mkdir /home/casomarr/data; \
		fi ;
		@if [ ! -d /home/casomarr/data/wordpress ]; \
		then \
			mkdir /home/casomarr/data/wordpress; \
		fi ;
		@if [ ! -d /home/casomarr/data/mariadb ]; \
		then \
			mkdir /home/casomarr/data/mariadb; \
		fi ;

add_env_variables :
		@echo "Adding the .env file."
		@if [ ! -e srcs/.env ]; \
		then \
			cp /home/casomarr/.env srcs/; \
		fi;

remove_env_variables :
		@echo "Removing the .env file."
		@if [ -e srcs/.env ]; \
		then \
			rm -f srcs/.env; \
		fi;

remove_volumes_folders :
		@echo "Removing the volumes' folders."
		@if [ -d /home/casomarr/data/wordpress ]; \
		then \
			sudo rm -rf /home/casomarr/data/wordpress; \
		fi;
		@if [ -d /home/casomarr/data/mariadb ]; \
		then \
			sudo rm -rf /home/casomarr/data/mariadb; \
		fi;
		@if [ -d /home/casomarr/data ]; \
		then \
			sudo rm -rf /home/casomarr/data; \
		fi;

#removes containers
down :
	@if [ ! -e srcs/.env ]; \
	then \
		cp /home/casomarr/.env srcs/; \
	fi;
	docker compose -f ./srcs/docker-compose.yml down

clean: down
		@echo "Stopping and removing the containers."
#removes images (docker image ls)
		docker system prune -af
#removes volumes (docker volume ls)
		@if [ "docker volume ls -f name=srcs_mariadb" ]; \
		then \
			docker volume rm -f srcs_mariadb; \
		fi ;
		@if [ "docker volume ls -f name=srcs_wordpress" ]; \
		then \
			docker volume rm -f wordpress; \
		fi ;

fclean: clean remove_env_variables remove_volumes_folders

re: 	fclean all

logs_m:
		docker logs mariadb_container

logs_w:
		docker logs wordpress_container

.PHONY:	all re clean create_volumes_folders add_env_variables remove_env_variables logs_m logs_n logs_w



# To build a docker separetly (without docker-compose.yml) :
# docker build -t nginx_img srcs/requirements/NGINX
# docker run -d -p 443:443 nginx_img
# OR
# docker run -it nginx
# docker down nginx_img


#to connect with regular user:
#https://casomarr.42.fr
#to connect with admin user:
#https://casomarr.42.fr/wp-admin

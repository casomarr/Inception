# SRCS = 	srcs/requirements/MariaDB/conf/50-server.cnf \
#         srcs/requirements/MariaDB/conf/mariaDB.sh \
#         srcs/requirements/MariaDB/Dockerfile \
#         srcs/requirements/NGINX/conf/nginx.conf \
#         srcs/requirements/NGINX/Dockerfile \
#         srcs/requirements/WordPress/conf/cli_config.sh \
#         srcs/requirements/WordPress/conf/www.conf \
#         srcs/requirements/WordPress/Dockerfile \

# # srcs/docker-compose.yml \

# all: ${SRCS} create_volumes_folders add_env_variables
# # docker compose
# 		@echo "Building the containers."
# 		sudo docker compose -f ./srcs/docker-compose.yml up -d --build

# create_volumes_folders :
# 		@echo "Creating the volumes' folders."
# 		@if [ ! -d /home/casomarr/data/ ]; \
# 		then \
# 			sudo mkdir /home/casomarr/data; \
# 		fi ; \
# 		if [ ! -d /home/casomarr/data/wordpress ]; \
# 		then \
# 			sudo mkdir /home/casomarr/data/wordpress; \
# 		fi ; \
# 		if [ ! -d /home/casomarr/data/mariadb ]; \
# 		then \
# 			sudo mkdir /home/casomarr/data/mariadb; \
# 		fi ;

# add_env_variables :
# 		@echo "Adding the .env file."
# 		@if [ ! -e srcs/.env ]; \
# 		then \
# 			sudo cp /home/casomarr/.env srcs/; \
# 		fi;

# remove_env_variables :
# 		@echo "Removing the .env file."
# 		@if [ -e srcs/.env ]; \
# 		then \
# 			sudo rm -f srcs/.env; \
# 		fi;

# remove_volumes_folders :
# 		@echo "Removing the volumes' folders."
# 		sudo rm -rf /home/casomarr/data/wordpress
# 		sudo rm -rf /home/casomarr/data/mariadb
# 		sudo rm -rf /home/casomarr/data

# clean:
# 		@echo "Stoping and removing the containers."
# 		sudo docker compose -f ./srcs/docker-compose.yml down
# 		sudo docker system prune -af

# # down: 	${SRCS} 
# # 		sudo docker compose -f ./srcs/docker-compose.yml down 

# # clean :	down
				
# # 		@if [ "docker images nginx_img" ]; \
# # 		then \
# # 			docker rmi -f nginx_img; \
# # 		fi ; \
# # 		if [ "docker images mariadb_img" ]; \
# # 		then \
# # 			docker rmi -f mariadb_img; \
# # 		fi ; \
# # 		if [ "docker images wordpress_img" ]; \
# # 		then \
# # 			docker rmi -f wordpress_img; \
# # 		fi ; \
# # 		if [ "docker volume ls -f name=srcs_mariadb" ]; \
# # 		then \
# # 			docker volume rm -f srcs_mariadb; \
# # 		fi ; \
# # 		if [ "docker volume ls -f name=srcs_wordpress" ]; \
# # 		then \
# # 			docker volume rm -f wordpress; \
# # 		fi ; \
# # 		docker system prune -af;
# #verifier srcs_mariadb et srcs_wordpress

# fclean: clean remove_env_variables remove_volumes_folders

# re: 	fclean all

# logs_m:
# 		sudo docker logs mariadb_container

# logs_n:
# 		sudo docker logs nginx_container

# logs_w:
# 		sudo docker logs wordpress_container

# .PHONY:	all re clean create_volumes_folders add_env_variables remove_env_variables logs_m logs_n logs_w


# #https://casomarr.42.fr

# # To build a docker separetly (without docker-compose.yml) :
# # sudo docker build -t nginx_img srcs/requirements/NGINX
# # sudo docker run -d -p 443:443 nginx_img
# # OR
# # sudo docker run -it nginx
# # sudo docker down nginx_img




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
		sudo docker compose -f ./srcs/docker-compose.yml up -d --build

create_volumes_folders :
		@echo "Creating the volumes' folders."
		@if [ ! -d /home/casomarr/data/ ]; \
		then \
			sudo mkdir /home/casomarr/data; \
		fi ; \
		if [ ! -d /home/casomarr/data/wordpress ]; \
		then \
			sudo mkdir /home/casomarr/data/wordpress; \
		fi ; \
		if [ ! -d /home/casomarr/data/mariadb ]; \
		then \
			sudo mkdir /home/casomarr/data/mariadb; \
		fi ;

add_env_variables :
		@echo "Adding the .env file."
		@if [ ! -e srcs/.env ]; \
		then \
			sudo cp /home/casomarr/.env srcs/; \
		fi;

remove_env_variables :
		@echo "Removing the .env file."
		@if [ -e srcs/.env ]; \
		then \
			sudo rm -f srcs/.env; \
		fi;

remove_volumes_folders :
		@echo "Removing the volumes' folders."
		sudo rm -rf /home/casomarr/data/wordpress
		sudo rm -rf /home/casomarr/data/mariadb
		sudo rm -rf /home/casomarr/data

clean:
		@echo "Stoping and removing the containers."
#removes containers
		sudo docker compose -f ./srcs/docker-compose.yml down
#removes images (sudo docker image ls)
		sudo docker system prune -af
#removes volumes (sudo docker volume ls)
		@if [ "sudo docker volume ls -f name=srcs_mariadb" ]; \
		then \
			sudo docker volume rm -f srcs_mariadb; \
		fi ; \
		if [ "sudo docker volume ls -f name=srcs_wordpress" ]; \
		then \
			sudo docker volume rm -f wordpress; \
		fi ;
#IMPORTANT: pourquoi les volumes portent le nom type srcs_wordpress? pourquoi srcs devant?
#IMPORTANT: besoin d'eviter de mettre sudo partout cf 42evals!!

fclean: clean remove_env_variables remove_volumes_folders

re: 	fclean all

logs_m:
		sudo docker logs mariadb_container

#IMPORTANT: logs_n ne marche pas???
logs_n:
		sudo docker logs nginx_container

logs_w:
		sudo docker logs wordpress_container

.PHONY:	all re clean create_volumes_folders add_env_variables remove_env_variables logs_m logs_n logs_w


#to connect with regular user:
#https://casomarr.42.fr
#to connect with admin user:
#https://casomarr.42.fr/wp-admin

# To build a docker separetly (without docker-compose.yml) :
# sudo docker build -t nginx_img srcs/requirements/NGINX
# sudo docker run -d -p 443:443 nginx_img
# OR
# sudo docker run -it nginx
# sudo docker down nginx_img


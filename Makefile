
#je pense qu'ici iront les commandes type :
# sudo docker build -t nginx_img srcs/requirements/NGINX
# sudo docker run -d -p 443:443 nginx_img
# OR
# sudo docker run -it nginx

# sudo docker build -t mariadb_img srcs/requirements/MariaDB
# sudo docker run -d -p 3306  mariadb_img
# OR
# sudo docker run -it mariadb

# sudo docker build -t wordpress_img srcs/requirements/WordPress

# to build docker compose :
# sudo docker-compose -f  <path_docker_compose>  -d —build
# --> sudo docker-compose -f srcs/ -d —build
# Pour l’arrêter :    docker-compose -f  <path_docker_compose>  stop
# Pour supprimer le build :    docker-compose -f  <path_docker_compose>  down -v



sudo docker compose -f ./srcs/docker-compose.yml up -d --build

sudo docker compose -f ./srcs/docker-compose.yml stop

# pour débeuguer :
docker compose logs wordpress_container
#pour tout supprimer de temps en temps
sudo docker system prune -af
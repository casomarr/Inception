# INCEPTION PROJECT

## Objective :

Setting up a website using Docker containers, Nginx, MariaDB, and WordPress.

## Docker Containers

### What are they?

Docker is a tool that allows you to run applications in isolated environments called containers.
NGINX, MariaDB and WordPress each have to be set up and run in a different container. It is as if they each where being tested in a separate VM to be sure everything works before putting it together. But a container is smaller than a VM : a Docker container is like a well-organized toolkit, while a virtual machine (VM) is like a fully furnished apartment. The toolkit (Docker container) includes only the essential tools and components needed for a specific task, making it lightweight and easy to carry around. In contrast, the fully furnished apartment (VM) has everything needed to live, including the operating system and all its resources, making it heavier and more resource-intensive.

### Docker Images

To run, each docker container needs to download a software package (but in its more lightweight possible version) : a docker image. 

When we use a Docker image without Docker Compose, we manually handle the setup and management of containers : we pull the image from Docker Hub (with the command `docker pull <image_name>`) and run it (with the command `docker run`).

Ex: `docker run -d -p 80:80 nginx` manually created the container from the nginx image and connects port 80 of the container to port 80 on the host (in that same command line we could have also added network settings, environment variables and data volumes for example).

When we need to define multiple services, it is better to manage them collectively in a docker-compose.yml file.

### Why are they are useful?

Isolation: Each container runs independently, so problems in one container don't affect others. \
Portability: Containers can run consistently across different environments, from your local machine to cloud servers. \
Efficiency: Containers share the host system's kernel, making them more lightweight and faster to start than virtual machines. \


## Setting up the website

Three components: Nginx, MariaDB, and WordPress.

### 1. Nginx:

When a user types our website's url, NGINX is the service in charge of delivering the requested web page. \
When NGINX receives requests from users, it forwards them to the other servers and returns the answers to the users (like a relay point). \
It stores copies of web pages and other content so that future requests for the same content load faster.

To open the container terminal :
`docker exec -it nginx_container /bin/bash`

### 2. MariaDB:

MariaDB is a database management system that stores website’s data, like user information, posts, and comments.

To login into the database :

`docker exec -it mariadb_container mysql -u casomarr -p` \
`<enter password>` \
`USE wordpress;` \
`SHOW TABLES;` \
`SELECT * FROM wp_users;`

### 3. WordPress:

WordPress is a content management system that makes it easy to create and manage a website without needing to code everything from scratch.

To open the container terminal :
`docker exec -it wordpress_container /bin/bash`

## How do they work together?

WordPress interacts with users through a web interface, allowing them to view and manage content. It relies on Nginx to serve the content. \
WordPress needs to store data, such as posts and user information, which it does in the MariaDB database.

### Docker-Compose:

Docker-compose is a YAML file that allows to configure how the different containers will work together :
- we indicate what are the different containers that compose the application/website : we call them **Services**.
- we define how the containers will comunicate with each other : we call it **Networks** (docker-compose sets one by default but we can change it).
- we indicate where we would like to store the data generated and used by the different containers to allow data to persist (ex: where will be stored the comment I added to my web page) : we call that **Volumes**.

## What makes it an interesting setup?

**Separation of Concerns:** Each component (web server, application, database) is handled by a specialized tool, making the system more modular and easier to manage.

**Scalability:** You can easily scale individual components (e.g., add more WordPress instances) without affecting others.

**Maintainability:** Updates and maintenance can be done on individual containers without disrupting the entire system.
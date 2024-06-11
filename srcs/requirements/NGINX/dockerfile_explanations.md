# DOCKERFILE EXPLANATION

## FROM instruction to specify base image
`FROM debian:buster` --> Container's OS : we specify what image we want our dockerfile to use as base.
Debian is simpler and uses the Linux kernel, Alpine is lighter but you have to install things yourself.

## RUN instruction to install dependencies in our container

`RUN apt update && apt upgrade -y`

`RUN apt install nginx -y`

`RUN apt install openssl -y`

- We should limit as much as possible the number of RUN instructions to limit the number of layers created and therefore the size of our docker image.
- -y allows to automatically answer yes to questions like "It will take X space, do you want to continue?".
- a single `RUN` and all dependencies separated by `&&` allows to create fewer layers.

## SSL Certificate

`RUN mkdir -p /etc/nginx/ssl` --> Creates a folder to store the certificate and key for a secure connection.

`RUN apt install openssl -y`--> downloads the main tool for SSL certificate creation and management: OpenSSL.

`RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=casomarr.42.fr/UID=casomarr"`--> Generates an SSL certificate.
- `req` to create certificates.
- `-x509` to pindicate the type of certificate.
- `-nodes` so that our private key does not have a password (because we cannot type a password during the creation of the docker so for the same reason that we add -y above we must here also ensure that nothing blocks the creation of our docker).
- `-out` and `-keyout` tell OpenSSL where we want to store the certificate and key of our SSL.
- `-subj` prevents us from being asked for information to complete the certificate (again, so that we don't block the creation of the docker).

## NGINX configuration

`COPY conf/nginx.conf /etc/nginx/nginx.conf` --> puts the default config doc in etc in the conf folder to respect the structure of the subject

Add the rights we need :

`RUN chmod 755 /var/www/html`--> our main root

`RUN chown -R www-data:www-data /var/www/html` --> the main user

## EXPOSE instruction for HTTP

`EXPOSE 443`

- The EXPOSE instruction indicates on which port our application listens.
- The subject says to set it on port 443.

## To launch nginx
CMD [ "nginx", "-g", "daemon off;" ]
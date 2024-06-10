#Container's OS : we specify what image we want our dockerfile to use as base
FROM debian:buster
#debian est plus simple et utilise le noyeau linux, alpine est plus léger mais faut installer des trucs par soit-même

#Dependencies : RUN instruction to execute commands in our container
#We should limit as much as possible the number of RUN instructions to limit
#the number of layers created and therefore the size of our docker image
RUN apt update && apt upgrade -y
RUN apt install nginx -y
RUN apt install openssl -y
#-y permet de répondre automatiquement oui aux questions type "It will take X space, do you want to continue?"

#création d'un dossier pour stocker le certificat et la clef pour une connexion sécurisée
RUN mkdir -p /etc/nginx/ssl
#On télécharge l’outil principal pour la gestion/création de certificat SSL: OpenSSL
RUN apt install OpenSSL -y
#Génération d'un certificat TSL/SSL
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=casomarr.42.fr/UID=casomarr"
# req pour créer des certificats
# -x509 pour préciser le type du certificat
# -nodes pour que notre clé privée n'ait pas de mot de passe (car on ne peut pas taper un mdp pendant la création du docker donc pour la même raison qu'on rajoute -y plus haut il faut ici aussi qu'on fasse en sorte que rien ne bloque la création de notre docker)
# -out et -keyout indiquent à OpenSSL où l’on souhaite stocker le certificat et la clef de notre SSL
# -subj évite qu'on nous demande des informations pour remplir le certificat (afin qu'on ne bloque tjrs pas la création du docker)

#HERE : fix d'abord pourquoi j'arrives pas à build à cause d'OPENSSL
#HERE!!! : https://tuto.grademe.fr/inception/ : "Nous allons ensuite créer un dossier"

#The EXPOSE instruction indicates on which port our application listens.
#The subject says to set it on port 443.
EXPOSE 443

# To launch nginx 
CMD [ "nginx", "-g", "daemon off;" ]
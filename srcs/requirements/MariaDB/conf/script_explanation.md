# MariaDB.sh explanation

Script that creates a database and an associated user. This script will be executed by the dockerfile.

## Launch MySQL
`service mysql start;`

## Configuration :

If the env variable SQL_DATABASE does not exist, create a table to this variable's name, indicated in my .env file, that will be sent through the docker-compose.yml file.

`mysql -e "CREATE DATABASE IF NOT EXISTS \${SQL_DATABASE}\;"`

Create a user that will be able to manipulate said table :
- User = SQL_USER.
- The table SQL_DATABASE's password = SQL_PASSWORD.
- They will each be set in the .env file.

`mysql -e "CREATE USER IF NOT EXISTS \${SQL_USER}\@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"`

Give this user all rights :

`mysql -e "GRANT ALL PRIVILEGES ON \${SQL_DATABASE}\.* TO \${SQL_USER}\@'%' IDENTIFIED BY '${SQL_PASSWORD}';"`

Change the root user's rights with the root password :

`mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"`

Refresh so that MySQL takes these changes into account :

`mysql -e "FLUSH PRIVILEGES;"`

Re-launch MySQL :

`mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown` --> shuts MySQL down
`exec mysqld_safe`--> launches MySQL





#SCRIPT COMMENTS
[mysqld] #indicates for which category are the following configurations 
port = 3306 #VERIFIER : JE NE VOIS PAS QUE 3306 SOIT PRÉCISÉ DANS LE SUJET
bind_address=* #indicates that aññ IP can connect
datadir=/var/lib/mysql #indicates which folder will store our database
user=mysql
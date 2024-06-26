# MariaDB.sh explanation

Script that creates a database and an associated user. This script will be executed by the dockerfile.

## Launch MySQL
`service mariadb start`

## Configuration :

If the env variable SQL_DATABASE does not exist, create a table to this variable's name, indicated in my .env file, that will be sent through the docker-compose.yml file.

`echo "CREATE DATABASE IF NOT EXISTS \${SQL_DATABASE}\;" | mariadb -u root`

`echo "CREATE USER IF NOT EXISTS \${SQL_USER}\@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" | mariadb -u root`

Create a user that will be able to manipulate said table :
- User = SQL_USER.
- The table SQL_DATABASE's password = SQL_PASSWORD.
- They will each be set in the .env file.

Give this user all rights :

`echo "GRANT ALL PRIVILEGES ON \${SQL_DATABASE}\.* TO \${SQL_USER}\@'% IDENTIFIED BY ${SQL_PASSWORD};" | mariadb -u root`

Change the root user's rights with the root password :

`echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" | mariadb -u root`

Refresh so that MySQL takes these changes into account :

`echo "FLUSH PRIVILEGES;" | mariadb -u root -p$SQL_ROOT_PASSWORD`

Re-launch MySQL :

`exec mysqld_safe`




# Configuration file Explanation (50-server.cnf)
`[mysqld]` indicates for which category are the following configurations. \
`port = 3306` it is the default port for MySQL and MariaDB servers. It indicated which port to listen on. \
`bind_address=*` specifies the IP address that the MariaDB server will bind to. Setting it to * means the server will listen on all available IP addresses. This allows the server to accept connections from any network interface on the machine. \
`datadir=/var/lib/mysql` indicates which folder will store our database. It is the default directory for database and configuration files. \
`user=mysql` sets the user account under which MariaDB will run to a non root user created specifically for this purpose.
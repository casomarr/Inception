#!/bin/bash

#script that creates a database and an associated user
#(see script.md's explanations)

#launch MySQL
service mysql start;

#configuration :

mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#refresh
mysql -e "FLUSH PRIVILEGES;"

#re-launch
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe
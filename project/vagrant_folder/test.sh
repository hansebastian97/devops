#!/bin/bash

DATABASE_PASS="17101997"
# Set root password
# sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" --force -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') where User='root'"

# Disable root user access
sudo mysql -u root -p"$DATABASE_PASS" --force -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost','127.0.0.1','::1')"

# Remove anonymouse users
sudo mysql -u root -p"$DATABASE_PASS" --force -e "DELETE FROM mysql.user WHERE User=''"

# Remove test database and access
sudo mysql -u root -p"$DATABASE_PASS" --force -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"

# Create database accounts
sudo mysql -u root -p"$DATABASE_PASS"  -ef "CREATE DATABASE accounts"

# Create admin user
sudo mysql -u root -p"$DATABASE_PASS" -ef "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' identified by '$DATABASE_PASS'"
sudo mysql -u root -p"$DATABASE_PASS" -ef "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' identified by '"$DATABASE_PASS"'"

#!/bin/bash
DATABASE_PASS="17101997"
# Update required packages
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git zip unzip -y

# Install Mariadb
sudo yum install mariadb-server -y

# Start Mariadb service
sudo systemctl start mariadb
sudo systemctl enable mariadb


## MySQL Setup
# sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" --force -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') where User='root'"

# Disable root user access
sudo mysql -u root -p"$DATABASE_PASS" --force -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost','127.0.0.1','::1')"

# Remove anonymouse users
sudo mysql -u root -p"$DATABASE_PASS" -ef "DELETE FROM mysql.user WHERE User=''"

# Remove test database and access
sudo mysql -u root -p"$DATABASE_PASS" -ef "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"

# Create database accounts
sudo mysql -u root -p"$DATABASE_PASS" -ef "CREATE DATABASE accounts"

# Create admin user
sudo mysql -u root -p"$DATABASE_PASS" -ef "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' identified by '$DATABASE_PASS'"
sudo mysql -u root -p"$DATABASE_PASS" -ef "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' identified by '"$DATABASE_PASS"'"

# Import data into accounts table
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vprofile-project/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -ef "FLUSH PRIVILEGES"

sudo systemctl restart mariadb

# 
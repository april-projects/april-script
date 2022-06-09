#!bin/bash

# update linux
apt-get update -y && apt-get upgrade -y

# install nginx
apt install nginx-full -y

# install java
apt install default-jdk -y

# install maven
apt install maven -y

# install redis
apt install redis-server -y

# install memcached
apt install memcached -y 

# install git
apt install git -y

# get summer-install
git clone https://github.com/cn-cerc/summer-install.git

# start redis
# redis-server

# test redis
# redis-cli

# start memcached
memcached -d -m 1024 -p 11211 -u root

# test memcached
# telnet 127.0.0.1 11211

# quit memcached
# quit
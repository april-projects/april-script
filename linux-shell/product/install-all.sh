#!bin/bash

# update linux
apt-get update -y && apt-get upgrade -y && apt install htop -y

# install git
apt install git -y && git clone https://github.com/cn-cerc/summer-install.git

# install maven
apt install maven -y

# install nginx
apt install nginx-full -y

# innstall docker
apt install docker.io -y

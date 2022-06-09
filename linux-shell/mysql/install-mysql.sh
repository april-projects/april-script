#!/bin/bash

cd ~/

# 下载基础开发包
wget https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb

# 安装基础包
sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb

# 更新软件列表
sudo apt-get update -y

# 安装 mysql
sudo apt-get install mysql-server mysql-common -y

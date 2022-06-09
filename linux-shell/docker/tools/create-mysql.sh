#!/bin/bash

# 下载镜像
docker pull mysql:5.7

# 启动镜像
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d --restart=always mysql:5.7

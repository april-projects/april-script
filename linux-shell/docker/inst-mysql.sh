#!/bin/bash

mkdir /mysql
cd /home
rm -rf mysql.tar
wget summer.cerc.cn/images/mysql.tar
cd /mysql
rm -rf mysql.tar.gz
wget summer.cerc.cn/profile/mysql.tar.gz
#mv /home/mymysql.tar.gz /mysql/mymysql_1
tar -zxvf /mysql/mysql.tar.gz 
cd /mysql/mysql
sudo docker load </home/mysql.tar
docker run -p 3306:3306 --name mymysql -v $PWD/conf/my.cnf:/etc/mysql/my.cnf -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=123456 -d mysql
exit 0

 
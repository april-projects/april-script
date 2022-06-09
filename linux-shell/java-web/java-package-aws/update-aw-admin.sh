#!/bin/bash

cd app-project

git checkout develop 

git pull

cd app-data

mvn clean install

cd ..

cd app-app

mvn clean package -P master 

cd ~

# 拷贝文件到亚马逊s3服务器
scp -i "aw-ecs2.pem" app-1.0.0.war ubuntu@ec2.compute.amazonaws.com:/home/ubuntu/

# 远程连接到亚马逊s3服务器
ssh -i "aw-ecs2.pem" ubuntu@ec2.ap-southeast-1.compute.amazonaws.com 

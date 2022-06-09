#!/bin/bash

# 删除本地的 maven 目录
rm -rf /root/.m2/repository/cn/cerc

cd ~/sample-project

git checkout master

git pull

cd sample-app

mvn clean package -P master

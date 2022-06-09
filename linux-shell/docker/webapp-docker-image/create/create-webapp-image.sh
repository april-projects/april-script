#!/bin/bash

# 原始镜像名称
SOURCE_IMAGE=diteng-webapp-release
# 镜像私服地址
REGISTRY_HOST=registry-vpc.cn-hangzhou.aliyuncs.com
# 镜像命名空间
NAMESPACE=diteng-release
# 接收镜像打包版本，默认取jenkins打包成功的编号
TAG=$1
# WAR包地址
WAR_HOST=http://172.16.2.42/job/diteng-beta/ws/diteng-app/target/diteng-app-1.0.0-SNAPSHOT.war

# 删除历史镜像
docker images | grep $SOURCE_IMAGE  | awk '{print $3}' | xargs docker rmi -f

# 登录私服仓库
# docker login -p password --username=user@aliyun.com $REGISTRY_HOST

# 获取应用程序
rm -rf ROOT.war
wget $WAR_HOST -O ROOT.war

# 构建应用镜像
docker build -t $REGISTRY_HOST/$NAMESPACE/$SOURCE_IMAGE:$TAG .

# 显示镜像列表
docker images

# 发布镜像版本
docker push  $REGISTRY_HOST/$NAMESPACE/$SOURCE_IMAGE:$TAG

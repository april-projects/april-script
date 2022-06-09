#!/bin/bash

# 原始镜像名称
SOURCE_IMAGE=diteng-webapp-release
# 镜像私服地址
REGISTRY_HOST=registry-vpc.cn-hangzhou.aliyuncs.com
# 镜像命名空间
NAMESPACE=diteng-release
# 接收镜像运行版本，默认 latest
TAG=$1

# 删除当前容器
docker ps | grep $SOURCE_IMAGE  | awk '{print $1}' | xargs docker rm -f

# 显示镜像列表
docker images

# 删除历史镜像
docker images | grep $SOURCE_IMAGE  | awk '{print $3}' | xargs docker rmi -f

# 登录私服仓库
docker login -p password --username=user@aliyun.com $REGISTRY_HOST

# 拉取镜像版本
docker pull  $REGISTRY_HOST/$NAMESPACE/$SOURCE_IMAGE:$TAG

# 显示镜像列表
docker images

# 创建容器版本-每个容器CPU权重是 512/1024
docker run --name app8101 -d -p 8101:8080 --restart always --cpu-shares 512 $REGISTRY_HOST/$NAMESPACE/$SOURCE_IMAGE:$TAG
sleep 10
docker run --name app8102 -d -p 8102:8080 --restart always --cpu-shares 512 $REGISTRY_HOST/$NAMESPACE/$SOURCE_IMAGE:$TAG

# docker logs -n512 -f app-8101

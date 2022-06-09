#!/bin/bash

# 下载镜像
docker pull memcached

# 启动镜像
docker run --name memcached -d -p 11211:11211 --restart=always memcached

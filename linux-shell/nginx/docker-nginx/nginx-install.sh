#!/bin/bash

# 拉取官方最新的 nginx 镜像
docker pull nginx

# 运行一个临时的 nginx 容器
docker run --name nginx nginx

# 拷贝容器的 ngixn 到宿主主机目录
docker cp nginx:/usr/sbin/nginx:/usr/sbin/nginx

# 删除临时的 nginx 容器
docker stop nginx && docker rm nginx

# 创建 https 的 CA 证书目录
mkdir /etc/nginx/cert

# 建立一个可用的 nginx 容器
docker run -d \
-p 80:80 \
-p 443:443 \
--restart=always \
--name nginx \
-v /etc/nginx/html:/usr/share/nginx/html \
-v /etc/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v /etc/nginx/conf.d:/etc/nginx/conf.d:ro \
-v /etc/nginx/cert:/etc/nginx/cert:ro \
nginx
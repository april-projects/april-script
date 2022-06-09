#!/bin/bash

# 安装Memcache服务端
apt-get install memcached

# 启动该服务
memcached -d -m 512 -p 11211 -u root


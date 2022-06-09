#!/bin/bash

# 下载镜像
docker pull redis

# 启动镜像
docker run --name redis -d -p 6379:6379 --restart=always redis --requirepass "7vRRH9dchTjOwepD"

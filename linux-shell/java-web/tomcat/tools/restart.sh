#!/bin/bash

app=$1

# 停止服务容器
sh ~/tomcats/$app/bin/shutdown.sh

# 等待彻底停机
sleep 10

# 启动服务容器
sh ~/tomcats/$app/bin/startup.sh

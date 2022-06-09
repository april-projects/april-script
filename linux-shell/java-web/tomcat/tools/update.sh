#!/bin/bash

cd ~

app=$1

# 停止服务容器
sh ~/tomcats/$app/bin/shutdown.sh

# 等待彻底停机
sleep 10

# 删除应用文件
rm -rf ~/tomcats/$app/webapps/ROOT
rm -rf ~/tomcats/$app/webapps/ROOT.war

# 复制应用文件
cp ~/diteng-app-1.0.0.war ~/tomcats/$app/webapps/ROOT.war

# 启动服务容器
sh ~/tomcats/$app/bin/startup.sh

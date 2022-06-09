#!/bin/bash

app=$1

# 停止服务容器
sh ~/tomcats/$app/bin/shutdown.sh

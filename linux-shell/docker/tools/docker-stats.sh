#!/bin/bash

# 格式化输出docker容器的名称
sudo docker stats $(docker ps --format={{.Names}})
#!/bin/bash
app=official-website

# 显示官网的日志信息
sudo docker logs --tail 200 -f $app

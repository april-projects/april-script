#!/bin/bash

app=$1

# 监控运行日志
tail -n 512 -f ~/tomcats/$app/logs/catalina.out

#!/bin/bash

# 停止 spring-boot 的jar运行方式
curl http://127.0.0.1/stop

sleep 30

PID=$(ps -ef | grep app-1.0.0.jar | grep -v grep | awk '{ print $2 }')
if [ -z "$PID" ]
then
    echo Application is already stopped.
else
    echo kill $PID
    kill $PID
    echo Application is stopped.
fi

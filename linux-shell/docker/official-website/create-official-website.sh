#!/bin/bash

app=official-website
port=8101

mkdir tomcats
mkdir tomcats/$app
mkdir tomcats/$app/webapps
mkdir tomcats/$app/webapps/ROOT
mkdir tomcats/$app/logs
mkdir tomcats/$app/root

# 复制静态网页内容到ROOT目录下
cp -r ~/www-zntieke-com/* ~/tomcats/$app/webapps/ROOT/

sudo docker run -d --name $app -p $port:8080 -h $app \
    --restart=always \
    -v ~/tomcats/$app/webapps:/usr/local/tomcat/webapps \
    -v ~/tomcats/$app/logs:/usr/local/tomcat/logs \
    -v ~/tomcats/$app/root:/root \
    -v /etc/localtime:/etc/localtime tomcat

docker logs --tail 200 -f $app

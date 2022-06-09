#!/bin/sh

cd /usr/local/src
wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.zip
unzip -d /usr/local apache-tomcat-8.0.33.zip

cd /usr/local
mv apache-tomcat-8.0.33/ tomcat8
chmod 774 tomcat8/bin/*.sh

# 将8080端口改成80
sed -i 's/port="8080"/port="80"/g' /usr/local/tomcat8/conf/server.xml
/usr/local/tomcat8/bin/startup.sh

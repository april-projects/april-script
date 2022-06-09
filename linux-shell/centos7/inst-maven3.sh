#!/bin/sh

cd /usr/local/src
wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip
unzip -d /usr/local apache-maven-3.5.2-bin.zip

cd /usr/local
mv apache-maven-3.5.2/ apache-maven

echo "MAVEN_HOME=/usr/local/apache-maven" >> /etc/profile
echo "PATH=\$PATH:\$MAVEN_HOME/bin" >> /etc/profile

# 使配置文件生效
source /etc/profile

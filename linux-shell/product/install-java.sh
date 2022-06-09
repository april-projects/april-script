#!/bin/sh

# 安装openjdk
apt-get install openjdk-8-jdk

# 修改配置文件
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile
echo "export JRE_HOME=${JAVA_HOME}/jre" >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH" >> /etc/profile
echo "export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH" >> /etc/profile

# 使配置文件生效
source /etc/profile

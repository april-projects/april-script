#!/bin/sh

yum install java-1.8.0-openjdk.x86_64 -y
yum install java-1.8.0-openjdk-devel.x86_64 -y
yum install unzip -y

# 修改配置文件
echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/profile
echo "JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk/jre" >> /etc/profile
echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin" >> /etc/profile
echo "CLASSPATH=:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JRE_HOME/lib" >> /etc/profile
echo "export JAVA_HOME JRE_HOME PATH CLASSPATH" >> /etc/profile
# 使配置文件生效
source /etc/profile

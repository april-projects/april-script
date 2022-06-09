#! /bin/bash

sudo apt-get update -y 

sudo apt-get upgrade -y

sudo apt install default-jdk -y 

sudo apt install htop -y 

#get http://mirror.bit.edu.cn/apache//jmeter/binaries/apache-jmeter-5.0.tgz 
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org//jmeter/binaries/apache-jmeter-5.1.1.tgz

tar -xzvf apache-jmeter-5.1.1.tgz

# 修改 jmeter.properties 
# set server.rmi.ssl.disable=true
# set server_port=1099
# set server.rmi.localport=1099
# vim /root/apache-jmeter-5.0/bin/jmeter.properties

# 启动slave服务端
# ./apache-jmeter-5.0/bin/jmeter-server


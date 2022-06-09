#!bin/bash

# update package
apt update && apt upgrade -y

# install java8
# apt install openjdk-8-jdk-headless -y
apt install openjdk-11-jdk-headless -y

# install git
apt install git -y

# install htop
apt install htop -y

# clone summer-install
git clone https://gitee.com/mimrc/summer-install.git

# install tomcat
cd ~
cp ~/summer-install/java-web/tomcat/tools/* ~
cp ~/summer-install/java-web/tomcat/apache-tomcat-9.0.53.tar.gz ~

cd ~
mkdir tomcats
touch ~/summer-application.properties

# 创建main环境
tar -zxvf apache-tomcat-9.0.53.tar.gz -C ~/tomcats/
cd tomcats
mv apache-tomcat-9.0.53 app8101
cd ~

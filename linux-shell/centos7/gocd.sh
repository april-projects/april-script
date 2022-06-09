#!/bin/bash

## 用于CentOs的脚本
## example: /bin/bash install-gocd.sh POSTGRES密码 docker镜像库 docker用户 git仓库用户名 docker加速镜像库
## gocd 插件 docker-registry-artifact-plugin的默认地址： https://github.com/gocd/docker-registry-artifact-plugin/releases/download
set -xv
set -e

# POSTGRES
POSTGRES_VERSION=13
POSTGRES_USER=$0 # POSTGRES 用户名
POSTGRES_PASSWORD="" # POSTGRES 密码

# 接收输入的 POSTGRES 密码
echo -n "Enter postgres password(请输入 postgres 密码):" # 参数-n的作用是不换行，echo 默认换行
read POSTGRES_PASSWORD

# git
GIT_VERSION="2.31.1"
GIT_USER=$1 #git仓库用户名

# docker
DOCER_REPO_PROVIDER=$2 # docker镜像库，示例 registry.cn-shenzhen.aliyuncs.com 或者docker.io
DOCKER_REGISTRY_MIRRORS=$3 # docker加速镜像库
DOCKER_USERNAME=$4 # docker用户
DOCKER_PASSWORD="" # docker密码

# GOCD
GOCD_VERSION="21.2.0-12498"
GOCD_BINARIES_MIRROR_URL=https://storage.qingwork.fun/mirror/gocd # 默认 https://download.gocd.org/binaries
GOCD_ARTIFACT_PLUGIN_VERSION="1.2.0-127"

CURRENT_PATH=$(pwd)

# 接收输入的 docker 密码
echo -n "Enter docker password(请输入docker密码):" # 参数-n的作用是不换行，echo 默认换行
read DOCKER_PASSWORD

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi

curl -o gitinstall.sh https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/gitinstall.sh

source ./gitinstall.sh

sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo

## 目录
TEMPPATH="/opt/data/tmp"
RESOURCE_PATH="/opt/data/resource" # .ssh等秘钥文件，与gocd相关

mkdir -p ${TEMPPATH} ${RESOURCE_PATH} ${RESOURCE_PATH}/ansible

sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo

sudo yum makecache

echo -e "========================================================"
echo -e "\033[44;37m 准备开始初始化gocd，以及安装 \033[0m"
echo -e "========================================================"

## 检查 wget 是否安装
if [ `rpm -qa | grep wget | wc -l` -eq 0 ]; then
    yum install -y wget

    echo -e "\033[42;37m 安装 wget 成功 \033[0m"
else
    echo -e "\033[41;37m 本地已经安装: wget \033[0m"
fi

## == #0 预检查 ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 下载 postgres 初始化文件 \033[0m"
echo -e "========================================================"

wget -O postgres_setup_gocd.sql https://gitee.com/newxiaoming/linux-shell/raw/master/gocd/postgres_setup_gocd.sql


## == #1: check gocd service ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #1: 检查gocd 服务是否已在运行 \033[0m"
echo -e "========================================================"

# 关闭go-server
if [[ `/bin/systemctl status go-server.service | sed -n '/running/p' | wc -l` -eq 0 ]]; then
    echo -e "\033[41;37m 没有发现启动 go-server ${GOCD_VERSION} \033[0m"
else
    echo -e "\033[41;37m go-server 已经启动，停止安装 \033[0m"
    
    exit 1
fi

# 关闭go-agent
if [[ `/bin/systemctl status go-agent.service | sed -n '/running/p' | wc -l` -eq 0 ]]; then
    echo -e "\033[41;37m 没有启动 go-agent ${GOCD_VERSION} \033[0m"
else
    echo -e "\033[41;37m go-agent 已经启动，停止安装 \033[0m"
    exit 1
fi

if [ $? -ne 0 ]; then
    echo -e "\033[41;37m #1 命令执行失败。 \033[0m"
    exit 1;
fi

## == #1: install git ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #1: 安装 git ${GIT_VERSION} \033[0m"
echo -e "========================================================"


if [[ `ls -la /usr/local/bin |grep git | wc -l ` -ne 0 ]]; then
    echo -e "========================================================"
    echo -e "\033[41;37m git 已安装。 \033[0m"
    echo -e "========================================================"
else
    gitInstall
fi


## == #1: install gocd ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #2: 检查gocd rpm是否存在，不存在则下载 \033[0m"
echo -e "========================================================"

if [ ! -f "go-server-${GOCD_VERSION}.noarch.rpm" ]; then
    wget -O ./go-server-${GOCD_VERSION}.noarch.rpm ${GOCD_BINARIES_MIRROR_URL}/${GOCD_VERSION}/rpm/go-server-${GOCD_VERSION}.noarch.rpm

    echo -e "\033[42;37m 下载 go-server ${GOCD_VERSION} 成功 \033[0m"
fi

if [ ! -f "go-agent-${GOCD_VERSION}.noarch.rpm" ]; then
    wget -O ./go-agent-${GOCD_VERSION}.noarch.rpm ${GOCD_BINARIES_MIRROR_URL}/${GOCD_VERSION}/rpm/go-agent-${GOCD_VERSION}.noarch.rpm

    echo -e "\033[42;37m 下载 go-agent ${GOCD_VERSION} 成功 \033[0m"
fi

## 检查 go-server和go-agent 是否安装
if [ `rpm -qa | grep go-server | wc -l` -eq 0 ]; then
    rpm -i ./go-server-${GOCD_VERSION}.noarch.rpm

    echo -e "\033[42;37m 安装 go-server ${GOCD_VERSION} 成功 \033[0m"
else
    echo -e "\033[41;37m本地已经安装: go-server. \033[0m"
fi

if [ `rpm -qa | grep go-agent | wc -l` -eq 0 ]; then
    rpm -i ./go-agent-${GOCD_VERSION}.noarch.rpm

    echo -e "\033[42;37m 安装 go-agent ${GOCD_VERSION} 成功 \033[0m"
else
    echo -e "\033[41;37m 本地已经安装: go-agent. \033[0m"
fi

## 安装插件 artifact plugin，安装插件需要重启go-server
if [ ! -f "docker-registry-artifact-plugin-${GOCD_ARTIFACT_PLUGIN_VERSION}.jar" ]; then
    wget -O ${TEMPPATH}/docker-registry-artifact-plugin-${GOCD_ARTIFACT_PLUGIN_VERSION}.jar ${GOCD_BINARIES_MIRROR_URL}/docker-registry-artifact-plugin/releases/download/v${GOCD_ARTIFACT_PLUGIN_VERSION}/docker-registry-artifact-plugin-${GOCD_ARTIFACT_PLUGIN_VERSION}.jar

    echo -e "\033[42;37m 下载 docker-registry-artifact-plugin ${GOCD_ARTIFACT_PLUGIN_VERSION} 成功 \033[0m"
fi

chown go:go ${TEMPPATH}/docker-registry-artifact-plugin-${GOCD_ARTIFACT_PLUGIN_VERSION}.jar
su go -c "mkdir -p /var/lib/go-server/plugins/external/"
su go -c "cp ${TEMPPATH}/docker-registry-artifact-plugin-${GOCD_ARTIFACT_PLUGIN_VERSION}.jar /var/lib/go-server/plugins/external/"

## == #3: 安装 docker ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #3: 安装 docker \033[0m"
echo -e "========================================================"

if [ `rpm -qa |grep docker | wc -l` -eq 0 ]; then
    echo -e "\033[42;37m 请用 docker 脚本安装: docker \033[0m"
else
    echo -e "\033[41;37m 本地已经安装: docker \033[0m"
fi

# 启动操作系统同时启动docker
# systemctl enable docker.service
# systemctl enable containerd.service

if [ $? -ne 0 ]; then
   echo -e "\033[41;37m 安装 docker 失败 \033[0m"

   exit 100
fi

## == #4: install postgres ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #4: 安装 postgres \033[0m"
echo -e "========================================================"

if [ `rpm -qa | grep postgres | wc -l` -eq 0 ]; then
    sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
    sudo yum install -y postgresql${POSTGRES_VERSION}-server postgresql${POSTGRES_VERSION}-contrib.x86_64
    # Optionally initialize the database and enable automatic start:
    sudo /usr/pgsql-${POSTGRES_VERSION}/bin/postgresql-${POSTGRES_VERSION}-setup initdb
    sudo systemctl enable postgresql-${POSTGRES_VERSION}
    sudo systemctl start postgresql-${POSTGRES_VERSION}

    echo -e "\033[42;37m 安装 postgresql ${POSTGRES_VERSION} 成功 \033[0m"
else
    echo -e "\033[41;37m本地已经安装: postgres. \033[0m"
fi

## 创建文件 .pgpass
# su go -c 'echo "localhost:5432:gocd:gocd_user:POSTGRES_PASSWORD" > ~/.pgpass && chmod 0600 ~/.pgpass'
# su go -c "sed -i 's/POSTGRES_PASSWORD/${POSTGRES_PASSWORD}/g' ~/.pgpass"
# su - go
# echo "localhost:5432:gocd:gocd_user:${POSTGRES_PASSWORD}" > ${TEMPPATH}/.pgpass
# chown go:go ${TEMPPATH}/.pgpass
# chmod 0600 ${TEMPPATH}/.pgpass
# su go -c "mv ${TEMPPATH}/.pgpass ~/.pgpass"

# cp ${RESOURCE_PATH}/psql/postgres_setup_gocd.sql ./postgres_setup_gocd.sql

tee ${TEMPPATH}/postgres_setup_gocd.sql <<-'EOF'
CREATE ROLE "POSTGRES_USER" PASSWORD 'POSTGRES_PASSWORD' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
CREATE DATABASE "gocd" ENCODING="UTF8" TEMPLATE="template0";
GRANT ALL PRIVILEGES ON DATABASE "gocd" TO "POSTGRES_USER";
ALTER ROLE "POSTGRES_USER" SUPERUSER;
EOF

sed -i "s/POSTGRES_USER/${POSTGRES_USER}/g" ${TEMPPATH}/postgres_setup_gocd.sql
sed -i "s/POSTGRES_PASSWORD/${POSTGRES_PASSWORD}/g" ${TEMPPATH}/postgres_setup_gocd.sql

sudo -iu postgres psql < ${TEMPPATH}/postgres_setup_gocd.sql

if [ $? -ne 0 ]; then
    echo -e "\033[41;37m 导入gocd的postgres数据库失败。 \033[0m"
    exit 1;
fi

## == #5: add user [go] to docker group ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #5: 添加用户[go]到docker组\033[0m"
echo -e "========================================================"

## add user [go] to docker group
id go >& /dev/null
usermod -aG docker go
# newgrp docker


if [ $? -ne 0 ]; then
   echo -e "\033[41;37m 添加用户[go]到docker组 失败 \033[0m"
fi


## == #6: create file /etc/go/db.properties ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #6: create file /etc/go/db.properties \033[0m"
echo -e "========================================================"

echo "db.driver=org.postgresql.Driver" > /etc/go/db.properties
echo "db.url=jdbc:postgresql://localhost:5432/gocd" >> /etc/go/db.properties
echo "db.user=gocd_user" >> /etc/go/db.properties
echo "db.password=${POSTGRES_PASSWORD}" >> /etc/go/db.properties
chown go:go /etc/go/db.properties



## == #9: 安装ansible并配置 ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #9: 安装ansible并配置 \033[0m"
echo -e "========================================================"

## 检查 ansible 是否安装
if [ `rpm -qa | grep ansible | wc -l` -eq 0 ]; then
    yum install -y centos-release-ansible-29

    echo -e "\033[42;37m 安装 ansible 成功 \033[0m"
else
    echo -e "\033[42;37m 本地已经安装: ansible \033[0m"
fi

# 检查ansible目录是否存在
su go -c "mkdir ~/ansible"

## == #10: ssh配置 ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #10: ssh配置 \033[0m"
echo -e "========================================================"

# 配置ssh部署公钥
if [ ! -d "/var/go/.ssh" ]; then
    echo -e "\033[41;37m .ssh目录不存在，正在新建。 \033[0m"
    su go -c "mkdir /var/go/.ssh"
else
    echo -e "\033[41;37m .ssh目录已存在，跳过新建。 \033[0m"
fi


sudo tee ${TEMPPATH}/config <<-'EOF'
StrictHostKeyChecking no
# 配置gitee.com
Host gitee.com 
    # 这个是真实的域名地址
    HostName gitee.com
    # 这里是id_rsa的绝对地址
    IdentityFile ~/.ssh/id_rsa
    # 配置登录时用什么权限认证--可设为publickey,password publickey,keyboard-interactive等
    PreferredAuthentications publickey
    # 配置使用用户名
EOF

#echo "    ${GIT_USER}" >> ./config

chown go:go ${TEMPPATH}/config
su go -c "cp ${TEMPPATH}/config ~/.ssh/config"
su go -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
su go -c "chmod 600 ~/.ssh/config"
# su go -c "chmod 600 ~/.ssh/id_rsa_2020"
su go -c "echo \"    User ${GIT_USER}\" >> ~/.ssh/config"

# 测试ssh
# su go -c "ssh -T git@gitee.com"

# if [ $? -ne 1 ]; then
#     echo -e "\033[41;37m ssh连接失败。。 \033[0m"
# fi

chmod 666 /var/run/docker.sock



## == #7: start docker、go-server、go-agent ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #7: 启动 docker、go-server、go-agent \033[0m"
echo -e "========================================================"

# 启动 docker
if [[ `/bin/systemctl status docker.service | sed -n '/running/p' | wc -l` -eq 0 ]]; then
    echo -e "\033[41;37m 正在启动 docker \033[0m"
    /bin/systemctl start docker.service
else
    echo -e "\033[41;37m 正在重启 docker \033[0m"
    sudo systemctl daemon-reload
    /bin/systemctl restart docker.service
fi

if [ $? -eq 0 ]; then
    echo -e "\033[41;37m docker启动成功。 \033[0m"
else
    echo -e "\033[41;37m docker启动失败。 \033[0m"

    exit 1;
fi

# 登录docker
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin ${DOCER_REPO_PROVIDER}

if [ $? -eq 0 ]; then
    echo -e "\033[42;37m docker 登录成功。 \033[0m"
else
    echo -e "\033[41;37m docker 登录失败。 \033[0m"

    exit 1;
fi

id

# 启动 go-server
if [[ `/bin/systemctl status go-server.service | sed -n '/running/p' | wc -l` -eq 0 ]]; then
    echo -e "\033[41;37m 正在启动 go-server \033[0m"
    sudo /bin/systemctl start go-server.service
else
    echo -e "\033[41;37m 重启 go-server \033[0m"
    sudo /bin/systemctl restart go-server.service
fi

if [ $? -eq 0 ]; then
    echo -e "\033[42;37m go-server启动成功。 \033[0m"
else
    echo -e "\033[41;37m go-server启动失败。 \033[0m"

    exit 1;
fi

# 启动 go-agent
if [[ `/bin/systemctl status go-agent.service | sed -n '/running/p' | wc -l` -eq 0 ]]; then
    echo -e "\033[41;37m 正在启动 go-agent \033[0m"
    sudo /bin/systemctl start go-agent.service
else
    echo -e "\033[41;37m 重启 go-agent \033[0m"
    sudo /bin/systemctl restart go-agent.service
fi

if [ $? -eq 0 ]; then
    echo -e "\033[42;37m go-agent启动成功。 \033[0m"
else
    echo -e "\033[41;37m go-agent启动失败。 \033[0m"

    exit 1;
fi



echo -e "========================================================"
echo -e "\033[41;37m 完成了gocd安装，请去git仓库配置部署密钥 \033[0m"
echo -e "========================================================"
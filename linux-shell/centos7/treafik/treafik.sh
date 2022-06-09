#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/treafik/treafik.sh -O -)" SSL证书路径(pem) SSL证书路径(key) traefik域名
# 示例：sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/treafik/treafik.sh -O -)" /opt/toolsrv/cert/xx.cn/Digicert-OV-DV-root.pem /opt/toolsrv/cert/xx.cn/xx.cn.key traefik-demo.xxxx.cn

set -xv

# ******************************************************
# * Author: new5tt
# * Release: 0.0.1
# * Create Time: 2021-12-31
# * Update Time: 2021-12-31
# * Script Description: 用来编译安装 treafik
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi


TREAFIK_VERSION=2.5 # stable
DISTRO= # Linux发行版
TMPDIR=/tmp
INSTALL_DIR=/opt/toolsrv/traefik
TRAEFIK_LOG_PATH=/opt/websrv/logs/traefik
CERTFILE_PATH=$0
KEYFILE_PATH=$1
TRAEFIK_URI=$2
CERTRESOLVER_NAME=$3
MAIN_DOMAIN=$4
SANS_DOMAIN=$5


## == #0 创建 treafik 目录 ===============================================================

mkdir -p ${INSTALL_DIR}/config
mkdir -p ${TRAEFIK_LOG_PATH}

## == #1 安装 htpasswd ===============================================================

yum -y install httpd-tools

## == #2 替换 treafik 的配置文件 ===============================================================

echo -e "========================================================"
echo -e "\033[42;37m 正在部署 treafik ${TREAFIK_VERSION} 镜像。 \033[0m"
echo -e "========================================================"

wget -O ${INSTALL_DIR}/docker-compose.traefik.yml https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/treafik/docker-compose.traefik.yml
wget -O ${INSTALL_DIR}/traefik.yaml https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/treafik/traefik.yaml
wget -O ${INSTALL_DIR}/config/dynamic_conf.yaml https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/treafik/config/dynamic_conf.yaml

sudo sed -i "s#path/to/cert.crt#${CERTFILE_PATH}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml
sudo sed -i "s#path/to/cert.key#${KEYFILE_PATH}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml
sudo sed -i "s#TRAEFIK_URI#${TRAEFIK_URI}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml
sudo sed -i "s#CERTRESOLVER_NAME#${CERTRESOLVER_NAME}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml
sudo sed -i "s#MAIN_DOMAIN#${MAIN_DOMAIN}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml
sudo sed -i "s#SANS_DOMAIN#${SANS_DOMAIN}#g" ${INSTALL_DIR}/config/dynamic_conf.yaml

## 检查traefik配置文件/opt/toolsrv/traefik/usersFile.txt是否存在
## 不存在就生成一个用户和随机密码
usersFile="/opt/toolsrv/traefik/config/usersFile.txt"

if [ ! -f "$usersFile" ]; then
	# 生成用户名
	username="timesuser"
	echo "traefik 登录用户名="$username
	# 生成密码
	password=`openssl rand -base64 8`
	echo "traefik 登录密码="$password
	htpasswd -cb $usersFile $username $password
fi

## == #3 创建网络  ===============================================================

network_name="network-traefik"
filterName=`docker network ls | grep $network_name | awk '{ print $2 }'`

if [ "$filterName" == "" ]; then
    #不存在就创建
    docker network create $network_name
fi

## == #4 卸载 htpasswd ===============================================================

yum -y remove httpd-tools

## == #5 运行 treafik 服务 ===============================================================

docker-compose -p traefik -f ${INSTALL_DIR}/docker-compose.traefik.yml up -d --no-recreate

# 检查 treafik 服务运行状态

# now=`date +"%Y-%m-%d %H:%M:%S"`

exist=`docker inspect --format '{{.State.Running}}' traefik`

if [ $? -eq 0 ]; then
    echo '******************************'
    echo -e "\033[44;37m 容器 [traefik] 部署成功，仓库：[treafik:${TREAFIK_VERSION}] \033[0m"
    echo '******************************'
else
    echo '******************************'
    echo -e "\033[44;37m 容器 [traefik] 部署失败，仓库：[treafik:${TREAFIK_VERSION}] \033[0m"
    echo '******************************'

    exit 1;
fi
#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/whoami/whoami.sh -O -)" traefik-demo.intoevidence.cn

set -xv

# ******************************************************
# * Author: new5tt
# * Release: 0.0.1
# * Create Time: 2022-01-03
# * Update Time: 2022-01-03
# * Script Description: 用来安装镜像 treafik/whoami
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi


VERSION=2.5 # stable
DISTRO= # 发行版
TMPDIR=/tmp
INSTALL_DIR=/opt/toolsrv/whoami
# CERTFILE_PATH=$0
# KEYFILE_PATH=$1
TRAEFIK_URI=$0


## == #0 创建 treafik 目录 ===============================================================

mkdir -p ${INSTALL_DIR}

## == #1 安装 treafik ===============================================================

echo -e "========================================================"
echo -e "\033[42;37m 正在部署 traefik/whoami 镜像。 \033[0m"
echo -e "========================================================"

wget -O ${INSTALL_DIR}/docker-compose.whoami.yml https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/whoami/docker-compose.whoami.yml

sudo sed -i "s#TRAEFIK_URI#${TRAEFIK_URI}#g" ${INSTALL_DIR}/docker-compose.whoami.yml

network_name="network-traefik"
filterName=`docker network ls | grep $network_name | awk '{ print $2 }'`

if [ "$filterName" == "" ]; then
    #不存在就创建
    docker network create $network_name
fi

docker-compose -p whoami -f ${INSTALL_DIR}/docker-compose.whoami.yml up -d --no-recreate

# 检查 treafik 安装是否成功

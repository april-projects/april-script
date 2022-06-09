#!/bin/bash

# 示例： sh -c "$(curl -fsSL https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/docker.sh)" https://5ur2nu11.mirror.aliyuncs.com
# 任何语句的执行结果不是true则应该退出

set -xv

DOCEER_REPO_PROVIDER=""
DOCEKR_REGISTRY_USERNAME=""
DOCEKR_REGISTRY_PASSWORD=""
DOCEKR_REGISTRY_SPEED=$0

start_time=$(date +%s)
echo -e "\033[44;37m 当前时间 $(date +%Y-%m-%d-%H:%M:%S) 成功。 \033[0m"

## 检查 wget 是否安装
if [ `rpm -qa | grep wget | wc -l` -eq 0 ]; then
    yum install -y wget

    echo -e "\033[42;37m 安装 wget 成功 \033[0m"
else
    echo -e "\033[41;37m 本地已经安装: wget \033[0m"
fi

## == #0 Set up the repository ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 Set up the repository \033[0m"
echo -e "========================================================"

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo wget -O /etc/yum.repos.d/docker-ce.repo https://repo.huaweicloud.com/docker-ce/linux/centos/docker-ce.repo 
sudo sed -i 's+download.docker.com+repo.huaweicloud.com/docker-ce+' /etc/yum.repos.d/docker-ce.repo

sudo yum makecache fast

# sudo yum-config-manager \
#     --add-repo \
#     https://repo.huaweicloud.com/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast

## == #1 Install Docker Engine ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 Install Docker Engine \033[0m"
echo -e "========================================================"

sudo yum install -y docker-ce docker-ce-cli containerd.io

## == #1 Start Docker ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 Start Docker \033[0m"
echo -e "========================================================"

sudo systemctl start docker

# docker 服务开机启动
systemctl enable docker.service

# 登录指定Docker Registry
#echo ${DOCEKR_REGISTRY_PASSWORD} | docker login --username ${DOCEKR_REGISTRY_USERNAME} --password-stdin ${DOCEER_REPO_PROVIDER}

sudo mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["DOCEKR_REGISTRY_SPEED"]
}
EOF

sudo sed -i "s#DOCEKR_REGISTRY_SPEED#${DOCEKR_REGISTRY_SPEED}#g" /etc/docker/daemon.json

sudo curl -L "https://storage.qingwork.fun/mirror/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo gpasswd -a $USER docker #将当前用户添加至docker用户组
newgrp docker #更新docker用户组

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi

sudo systemctl daemon-reload
sudo systemctl restart docker


echo -e "========================================================"
echo -e "\033[44;37m Start Docker ok \033[0m"
echo -e "========================================================"
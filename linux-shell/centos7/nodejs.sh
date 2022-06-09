#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/nodejs.sh -O -)"
# 任何语句的执行结果不是true则应该退出
set -e
set -v

# ******************************************************
# * Author: new5tt
# * Release: 1.0
# * Create Time: 2021-12-26
# * Update Time: 2021-12-26
# * Script Description: 用来编译安装 nodejs
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi


VERSION=v16.13.1 # stable
DISTRO=linux-x64
TMPDIR=/tmp
# NODEJS_URL=https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz
NODEJS_URL=https://storage.qingwork.fun/mirror/nodejs/node-${VERSION}-${DISTRO}.tar.xz

## == #0 安装 nodejs ===============================================================

echo -e "========================================================"
echo -e "\033[42;37m 正在安装 Nodejs ${VERSION}-${DISTRO}。 \033[0m"
echo -e "========================================================"

# 下载 protoBuf：
sudo mkdir -p /usr/local/lib/nodejs
# wget -O /tmp/node-v16.13.1-linux-x64.tar.xz --progress=dot:mega https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz
wget -O ${TMPDIR}/node-${VERSION}-${DISTRO}.tar.xz --progress=dot:mega ${NODEJS_URL}

sudo tar -xJvf ${TMPDIR}/node-${VERSION}-${DISTRO}.tar.xz -C /usr/local/lib/nodejs
rm -rf ${TMPDIR}/node-${VERSION}-${DISTRO}.tar.xz

# 设置环境变量
sudo tee /etc/profile.d/nodejs.sh <<-EOF
export PATH=$PATH:/usr/local/lib/nodejs/node-${VERSION}-${DISTRO}/bin
EOF

source /etc/profile

# test version
node -v

# 软链
sudo ln -s /usr/local/lib/nodejs/node-${VERSION}-${DISTRO}/bin/node /usr/bin/node
sudo ln -s /usr/local/lib/nodejs/node-${VERSION}-${DISTRO}/bin/npm /usr/bin/npm
sudo ln -s /usr/local/lib/nodejs/node-${VERSION}-${DISTRO}/bin/npx /usr/bin/npx

# 安装yarn
sudo npm install --global yarn
sudo ln -s /usr/local/lib/nodejs/node-${VERSION}-${DISTRO}/lib/node_modules/yarn/bin/yarn /usr/bin/yarn
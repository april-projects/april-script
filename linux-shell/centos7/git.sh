#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/git.sh -O -)"
# 任何语句的执行结果不是true则应该退出
set -e
set -v

# ******************************************************
# * Author: new5tt
# * Release: 1.0
# * Create Time: 2021-12-26
# * Update Time: 2021-12-26
# * Script Description: 用来编译安装 git
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi


VERSION=2.34.1 # stable
DISTRO=
TMPDIR=/tmp
# GITSCM_URL=https://www.kernel.org/pub/software/scm/git/git-2.34.1.tar.gz
GITSCM_URL=https://storage.qingwork.fun/mirror/gitscm/git-${VERSION}.tar.gz

## == #0 安装 git ===============================================================

echo -e "========================================================"
echo -e "\033[42;37m 正在安装 Nodejs ${VERSION}。 \033[0m"
echo -e "========================================================"

# 安装依赖和卸载旧版本
sudo yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc xmlto perl-devel perl-CPAN autoconf* libtool
sudo yum remove -y git

sudo mkdir -p /usr/local/lib/git
wget -O ${TMPDIR}/git-${VERSION}.tar.gz --progress=dot:mega ${GITSCM_URL}

tar zxvf ${TMPDIR}/git-${VERSION}.tar.gz -C ${TMPDIR}/
cd ${TMPDIR}/git-${VERSION}
make configure
./configure --prefix=/usr/local --with-iconv=/usr/local/libiconv
sudo make install

# 设置环境变量
sudo tee /etc/profile.d/git.sh <<-EOF
export PATH=$PATH:/usr/local/bin
EOF
source /etc/profile

# 检查git安装是否成功
git version

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 安装git ${VERSION} 失败。 \033[0m"
    echo -e "========================================================"

    exit 1;
else
    echo -e "========================================================"
    echo -e "\033[42;37m 安装 git ${VERSION} 成功。 \033[0m"
    echo -e "========================================================"
fi

cd -
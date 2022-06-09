#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/protobuf.sh -O -)"
# 任何语句的执行结果不是true则应该退出
set -e
set -v

# ******************************************************
# * Author: new5tt
# * Release: 1.0
# * Create Time: 2021-07-20
# * Update Time: 2021-12-10
# * Script Description: 用来编译安装 protobuf
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi

## == #0 安装 protoBuf ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 安装 protoBuf \033[0m"
echo -e "========================================================"

# 下载 protoBuf：
# git clone https://gitee.com/newxiaoming/protobuf.git
wget https://storage.qingwork.fun/mirror/protoc/protobuf-all-3.19.1.tar.gz

tar -xvf protobuf-all-3.19.1.tar.gz

# 安装依赖库
sudo yum install -y autoconf automake libtool curl make gcc-c++ unzip libffi-devel glibc-headers

# 进入目录
cd protobuf-3.19.1

# 配置环境：
./configure --host=x86_64

# 编译源代码(要有耐心！)：
make 

# check
make check

# 安装
sudo make install

# 刷新共享库 （很重要的一步啊）
sudo ldconfig 

# 成功后需要使用命令测试
protoc -h

# 删除
cd ..
rm -rf protobuf/
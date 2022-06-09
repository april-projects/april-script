#!/bin/sh

# 任何语句的执行结果不是true则应该退出
set -e
set -v

# ******************************************************
# * Author: new5tt
# * Release: 1.0
# * Create Time: 2021-07-20
# * Script Description: 用来编译安装 protobuf
# ******************************************************

## == #0 安装 protoBuf ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 安装 protoBuf \033[0m"
echo -e "========================================================"

# 下载 protoBuf：
git clone https://gitee.com/newxiaoming/protobuf.git

# 安装依赖库
sudo apt install -y autoconf  automake  libtool curl make  g++  unzip libffi-dev

# 进入目录
cd protobuf/ 

# 自动生成configure配置文件：
./autogen.sh 

# 配置环境：
./configure

# 编译源代码(要有耐心！)：
make 

# 安装
sudo make install

# 刷新共享库 （很重要的一步啊）
sudo ldconfig 

# 成功后需要使用命令测试
protoc -h

# 删除
cd ..
rm -rf protobuf/
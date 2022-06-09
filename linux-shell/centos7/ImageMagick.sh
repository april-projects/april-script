#!/bin/sh

# sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/ImageMagick.sh -O -)"
# 任何语句的执行结果不是true则应该退出
set -e
set -v

# ******************************************************
# * Author: new5tt
# * Release: 1.0
# * Create Time: 2021-12-14
# * Update Time: 2021-12-14
# * Script Description: 用来编译安装 ImageMagick
# ******************************************************

## 检查是否为centos
cat /etc/redhat-release

if [ $? -ne 0 ]; then
    echo -e "========================================================"
    echo -e "\033[41;37m 执行失败。Error Msg:必须是 CentOS Linux 操作系统。 \033[0m"
    echo -e "========================================================"

    exit 1;
fi

## == #0 安装 ImageMagick ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #1 依赖 \033[0m"
echo -e "========================================================"

sudo yum -y install ghostscript libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel libtiff libtiff-devel libungif libungif-devel freetype zlib

## == #1 安装 ImageMagick ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #1 安装 ImageMagick \033[0m"
echo -e "========================================================"

git clone https://gitee.com/newxiaoming/ImageMagick.git ImageMagick-7.1.0
sudo mv ImageMagick-7.1.0 /opt/program/

cd /opt/program/ImageMagick-7.1.0
./configure --host=x86_64 --prefix=/usr/local/ImageMagick --with-modules --enable-shared --with-gslib --with-jpeg --with-png --with-xml
# make check
make
sudo make install
sudo ldconfig

sudo tee /etc/profile.d/pkgconfig.sh <<-'EOF'
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
EOF

sudo tee /etc/profile.d/ldlibrarypath.sh <<-'EOF'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
EOF

source /etc/profile

magick identify -version

magick -version

convert -list configure
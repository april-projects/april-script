#!/bin/bash

# 任何语句的执行结果不是true则应该退出
set -e
set -xv

start_time=$(date +%s)
echo -e "\033[44;37m 当前时间 $(date +%Y-%m-%d-%H:%M:%S) 成功。 \033[0m"

# 安装 NGINX
NGINX_VERSION="nginx-1.20.2"
PCRE_VERSION="pcre-8.43"
ZLIB_VERSION="zlib-1.2.11"
BASE_DIR="/opt/websrv"
CONFIG_DIR="${BASE_DIR}/config"
INSTALL_DIR=${BASE_DIR}/program/nginx
EXTEND="gcc g++ c++ make bzip2 perl openssl-dev file gcc-c++ zlib zlib-devel gd gd-devel openssl openssl-devel"
WWWROOT_DIR="${BASE_DIR}/data/wwwroot"

NGINX_URL="http://nginx.org/download/${NGINX_VERSION}.tar.gz"
PCRE_URL="https://ftp.exim.org/pub/pcre/${PCRE_VERSION}.tar.gz"
ZLIB_URL="http://zlib.net/${ZLIB_VERSION}.tar.gz"
NGINX_CONFIGURE="./configure \
 --user=www \
 --group=wwww \
 --prefix=${INSTALL_DIR} \
 --conf-path=${CONFIG_DIR}/nginx/nginx.conf \
 --error-log-path=${BASE_DIR}/logs/error.log \
 --http-log-path=${BASE_DIR}/logs/access.log \
 --lock-path=${BASE_DIR}/tmp/nginx.lock \
 --pid-path=${BASE_DIR}/tmp/nginx.pid \
 --sbin-path=${INSTALL_DIR}/sbin/nginx \
 --with-http_v2_module \
 --with-http_slice_module \
 --with-http_addition_module \
 --with-http_dav_module \
 --with-http_degradation_module \
 --with-http_flv_module \
 --with-http_gzip_static_module \
 --with-http_mp4_module \
 --with-http_random_index_module \
 --with-http_realip_module \
 --with-http_secure_link_module \
 --with-http_ssl_module \
 --with-http_stub_status_module \
 --with-http_sub_module \
 --with-mail \
 --with-mail_ssl_module \
 --with-pcre \
 --with-stream_realip_module \
 --with-stream_ssl_module \
 --with-debug"

echo -e "\033[44;37m 安装NGINX ${NGINX_VERSION} \033[0m"

sudo yum install -y ${EXTEND}

sudo mkdir -p ${WWWROOT_DIR} ${BASE_DIR}/logs/nginx ${BASE_DIR}/tmp ${CONFIG_DIR}/nginx/certs.d ${INSTALL_DIR}/sbin/nginx ${BASE_DIR}/data/errors

wget ${NGINX_URL}
wget ${PCRE_URL} --no-check-certificate
# wget ${ZLIB_URL}

tar -zxf ${NGINX_VERSION}.tar.gz
tar -zxf ${PCRE_VERSION}.tar.gz
# tar -zxf ${ZLIB_VERSION}.tar.gz

groupadd wwww && adduser -g wwww www

cd ${PCRE_VERSION}
./configure
make && sudo make install

# cd ../
# cd ${ZLIB_VERSION}
# ./configure
# make && sudo make install
cd ../

cd ${NGINX_VERSION}
${NGINX_CONFIGURE}
make && sudo make install

# 软链
ln -s ${INSTALL_DIR}/sbin/nginx/nginx /usr/bin/nginx

# nginx 配置
wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/nginx/conf/nginx.conf -O ${CONFIG_DIR}/nginx/nginx.conf

# error文件夹
wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/nginx/errors/error_default.html -O ${BASE_DIR}/data/errors/error_default.html

echo -e "\033[44;37m 安装 NGINX ${NGINX_VERSION} 成功。 \033[0m"

end_time=$(date +%s)
interval_time=$end_time-$start_time
echo -e "\033[44;37m 构建安装 NGINX ${NGINX_VERSION} 总耗时： $(($interval_time/60))min $(($interval_time%60))s \033[0m"


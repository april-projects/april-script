#!/bin/bash

# 任何语句的执行结果不是true则应该退出
set -e
set -v

start_time=$(date +%s)
echo -e "\033[44;37m 当前时间 $(date +%Y-%m-%d-%H:%M:%S) 成功。 \033[0m"

# 安装 NGINX
NGINX_VERSION="nginx-1.18.0"
PCRE_VERSION="pcre-8.43"
ZLIB_VERSION="zlib-1.2.11"
BASE_DIR="/opt/websrv"
CONFIG_DIR="${BASE_DIR}/config"
INSTALL_DIR=${BASE_DIR}/program/nginx
EXTEND="gcc g++ c++ make bzip2 perl openssl-dev file"
WWWROOT_DIR="${BASE_DIR}/data/wwwroot"

NGINX_URL="http://nginx.org/download/${NGINX_VERSION}.tar.gz"
PCRE_URL="https://ftp.pcre.org/pub/pcre/${PCRE_VERSION}.tar.gz"
ZLIB_URL="http://zlib.net/${ZLIB_VERSION}.tar.gz"
CONFIGURE="./configure \
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
 --with-zlib"

echo -e "\033[41;37m 安装NGINX ${NGINX_VERSION} \033[0m"

yum install ${EXTEND}

mkdir -p ${WWWROOT_DIR} ${BASE_DIR}/logs/nginx ${BASE_DIR}/tmp ${CONFIG_DIR}/nginx/certs.d

wget ${NGINX_URL}
wget ${PCRE_URL}
wget ${ZLIB_URL}

tar -zxf ${NGINX_VERSION}.tar.gz
tar -zxf ${PCRE_VERSION}.tar.gz
tar -zxf ${ZLIB_VERSION}.tar.gz

groupadd wwww && adduser -g wwww www

cd ${PCRE_VERSION}
./configure
make && make install

cd ../
cd ${ZLIB_VERSION}
./configure
make && make install
cd ../

cd ${NGINX_VERSION}
${NGINX_CONFIGURE}
make && make install

rm -rf ${NGINX_VERSION}.tar.gz ${PCRE_VERSION}.tar.gz ${ZLIB_VERSION}.tar.gz

echo -e "\033[44;37m 安装 NGINX ${NGINX_VERSION} 成功。 \033[0m"


end_time=$(date +%s)
interval_time=$($end_time-$start_time)
echo -e "\033[44;37m 构建安装 NGINX ${NGINX_VERSION} 总耗时： $(($interval_time/60))min $(($interval_time%60))s \033[0m"


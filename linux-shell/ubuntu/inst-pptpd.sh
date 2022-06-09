#!/bin/sh
apt-get -y update;
apt-get -y install pptpd;
# 创建认证文件
echo "vpnuser    *           Vpn770088    *" >> /etc/ppp/chap-secrets;
pptpd restart;
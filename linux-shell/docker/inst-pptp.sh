#!/bin/bash

cd ~
mkdir pptp

# 创建认证文件
touch ~/pptp/chap-secrets
echo "# Secrets for authentication using PAP" >> ~/pptp/chap-secrets
echo "# client    server      secret      acceptable local IP addresses" >> ~/pptp/chap-secrets
echo "vpnuser    *           Vpn7788    *" >> ~/pptp/chap-secrets

docker run -d --privileged --net=host -v ~/pptp/chap-secrets:/etc/ppp/chap-secrets mobtitude/vpn-pptp
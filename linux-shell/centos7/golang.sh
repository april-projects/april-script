#!/bin/bash

# 示例： sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/golang.sh -O -)"
# 任何语句的执行结果不是true则应该退出
set -e
set -v

GOLANG_VERSION="1.17.4"

# GOLANG_URL="https://golang.google.cn/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz"
# GOLANG_URL="https://gomirrors.org/dl/go/go${GOLANG_VERSION}.linux-amd64.tar.gz"
GOLANG_URL="https://storage.qingwork.fun/mirror/go/${GOLANG_VERSION}/go${GOLANG_VERSION}.linux-amd64.tar.gz"

start_time=$(date +%s)
echo -e "\033[44;37m 当前时间 $(date +%Y-%m-%d-%H:%M:%S) 成功。 \033[0m"

## == #0 Download golang zip ===============================================================

echo -e "========================================================"
echo -e "\033[44;37m #0 Download golang zip \033[0m"
echo -e "========================================================"

wget ${GOLANG_URL}

sudo tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz

# sudo echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/golang.sh
sudo tee /etc/profile.d/golang.sh <<-'EOF'
export PATH=$PATH:/usr/local/go/bin
EOF

source /etc/profile

go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

go version
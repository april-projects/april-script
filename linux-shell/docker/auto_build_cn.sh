#!/bin/bash

cd ~

# 更新系统
apt update && apt upgrade -y

# 必备软件
apt install git -y
apt install htop
apt install docker.io -y

# 安装zsh
apt install zsh -y

# 切换至zsh
chsh -s /bin/zsh

# 下载插件
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

# 镜像加速
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://gmd9rm2w.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 获取脚本
git clone https://gitee.com/mimrc/summer-install.git

# 构建镜像
cd ~/summer-install/docker/factory
sh build.sh

# 拷贝脚本
cp -r ~/summer-install/docker/tools/*.sh ~

# 创建容器
cd ~

sh create.sh app8101 8101

sh create.sh app8102 8102

echo "应用环境初始化完成，请根据项目实际情况酌情修改 update.sh"

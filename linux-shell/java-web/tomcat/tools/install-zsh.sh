#!/bin/sh

# 更新软件列表
apt update

# 安装zsh
apt install zsh -y

# 切换至zsh
chsh -s /bin/zsh

# 下载插件
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

# 显示当前的shell
echo $SHELL

echo "Please restart shell to activate /bin/zsh \r"

# 1.更新主题为 ys，vim ~/.zshrc
# 2.重载入配置 source ~/.zshrc
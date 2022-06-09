#!/bin/bash

# 该脚本存在问题，不能正常执行。可以手动复制到命令行终端执行。 2022/04/03
# 脚本用于执行自定义设置vagrant box镜像
# demo: sh -c "$(curl -fsSL https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/setvagrantbox.sh)"
# 预安装工具: vim、net-tools、wget

## == #0 检查当前是否是root用户 ===============================================================

check_current_user=`whoami`
if [[ $check_current_user -ne "root" ]]; then
	echo "必须用root登录"
	exit 1;
fi

## == #1 更改yum源 ===============================================================

# 阿里云源
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Base.repo

yum clean all
yum makecache

## == #2 设置sudoers ===============================================================

# 说明：

# vagrant ，目标用户，表示用户
# 第一个ALL，目标主机，表示从任何的主机上都可以执行。
# 第二个ALL ，目标身份，本例中该值设为ALL，这意味着用户vagrant能够以任何用户的身份来运行后面列出的命令。
# NOPASSWD:ALL，让vagrant用户不必输入密码就能执行所有命令。

echo 'vagrant ALL=(ALL) NOPASSWD:ALL'>>/etc/sudoers

## == #3 关闭防火墙 ===============================================================

systemctl stop firewalld.service
systemctl disable firewalld.service

## == #4 关闭SElinux ===============================================================

sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

## == #5 安装其他服务 ===============================================================

# netstat使用到net-tools工具

yum install -y net-tools*
yum install -y wget


## == #6 openssh-server ===============================================================

yum install -y openssh-server
systemctl enable sshd.service
systemctl start sshd.service
systemctl status sshd.service ## 检查是否启动成功

## == #7 安装对应的kernel-devel ===============================================================

rpm -qa kernel*

yum install -y kernel-devel-$(uname -r)

## == #8 安装VirtualBox guest addition ===============================================================

yum clean all
yum install -y gcc make bzip2
curl -o /tmp/VBoxGuestAdditions_6.1.16.iso http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso
mkdir /media/VBoxGuestAdditions
mount -o loop,ro /tmp/VBoxGuestAdditions_6.1.16.iso /media/VBoxGuestAdditions
yum install -y elfutils-libelf-devel
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run

# 安装成功后卸载挂载的镜像
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions
rm /tmp/VBoxGuestAdditions_6.1.16.iso

## == #9 安装ntpd服务同步时间 ===============================================================

# yum install -y ntp
# systemctl enable ntpd.service
# systemctl stop ntpd.service
# # ntpdate cn.ntp.org.cn
# systemctl start ntpd.service
# ntpq -p

## == #10 添加vagrant的public key ===============================================================

su vagrant -c "mkdir -m 0700 -p /home/vagrant/.ssh"
su vagrant -c "curl -o ~/vagrant.pub http://storage.qingwork.fun/file/vagrant.pub" # 如果这个链接访问不了，请使用官方链接https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
su vagrant -c "cat ~/vagrant.pub >> /home/vagrant/.ssh/authorized_keys"
su vagrant -c "chmod 0600 /home/vagrant/.ssh/authorized_keys"



## == #11 清理操作 ===============================================================

yum clean all
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
history -c
su vagrant
history -c

## == #12 成功 ===============================================================

#shutdown -h now
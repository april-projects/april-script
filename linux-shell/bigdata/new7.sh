#!/bin/bash

if (($#==0)); then
    echo No args!;
    exit;
fi

if (($1<2 || $1>255)); then
    echo Invalid args!;
    exit
fi

hostnamectl --static set-hostname hadoop$1

cat >/etc/sysconfig/network-scripts/ifcfg-ens33 <<EOF
TYPE="Ethernet"
BOOTPROTO="static"
NAME="ens33"
DEVICE="ens33"
ONBOOT="yes"
IPADDR="192.168.1.$1"
PREFIX="24"
GATEWAY="192.168.1.2"
DNS1="192.168.1.2"
EOF

reboot


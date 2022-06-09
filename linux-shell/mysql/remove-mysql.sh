#!/bin/bash

# 卸载mysql
sudo rm /var/lib/mysql/ -R

sudo rm /etc/mysql/ -R

sudo apt-get autoremove mysql* --purge -y

sudo apt-get remove apparmor -y
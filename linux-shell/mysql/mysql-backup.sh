#!/bin/bash

# 备份mysql指定的数据库

mysqldump -P 3306 -h 127.0.0.1 -uroot -proot --databases db1 > /home/ubuntu/mysql/`date +%Y-%m-%d_`db.sql
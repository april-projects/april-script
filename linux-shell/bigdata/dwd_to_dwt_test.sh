#!/bin/bash

#获取运行天数,如果脚本第二个参数输入就用$2,如果不输入默认为10天
if [ -n "$2" ] ;then
    days=$2
else
    days=10
fi

#获取起始日期
start=$1

do_date=$start


for((i=0;i<$days;i++))
do
    
    echo ==================当前执行数仓插入数据日期:$do_date==================
    
    dwd_to_dwt.sh $do_date
    echo --------------${do_date}号的dwt层数据插入完毕--------------
    
    do_date=`date -d "$do_date +1 day" +%F`
    
done 

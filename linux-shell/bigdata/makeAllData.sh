#!/bin/bash

#获取运行天数,如果脚本第二个参数输入就用$2,如果不输入默认为10天
if [ -n "$2" ] ;then
	days=$2
else
	days=10
fi

#获取起始日期
start=$1

#生成相同天数的日志和业务数据,并采集到hdfs的origin_data目录下
makeLogData.sh $start $days
sleep 30
makeDBData.sh $start $days
sleep 30

do_date=$start

#写循环开始执行一步步的数据导入 origin->ods->dwd->dws->dwt
for((i=0;i<$days;i++))
do
    
    echo ==================当前执行数仓插入数据日期:$do_date==================
    
    hdfs_to_ods_log.sh $do_date
    hdfs_to_ods_db.sh all $do_date
    echo --------------${do_date}号的ods层数据插入完毕--------------
    
    ods_to_dwd_log.sh $do_date
    ods_to_dwd_db.sh all $do_date
    echo --------------${do_date}号的dwd层数据插入完毕--------------
    
    dwd_to_dws.sh $do_date
    echo --------------${do_date}号的dws层数据插入完毕--------------
    
    dwd_to_dwt.sh $do_date
    echo --------------${do_date}号的dwt层数据插入完毕--------------
    
    do_date=`date -d "$do_date +1 day" +%F`
    
done

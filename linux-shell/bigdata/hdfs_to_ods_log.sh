#!/bin/bash

hive=/opt/module/hive-3.1.2-spark-3.0/bin/hive
hadoop=/opt/module/hadoop-3.1.3/bin/hadoop

if [ -n "$1" ] ;then
	do_date=$1
else
	do_date=`date "-1 day" +%F`
fi

echo ================== 日志日期为 $do_date ==================

sql="use gmall;load data inpath '/origin_data/gmall/log/topic_log/$do_date' into table ods_log partition(dt='$do_date')"

$hive -e "$sql"

$hadoop jar /opt/module/hadoop-3.1.3/share/hadoop/common/hadoop-lzo-0.4.20.jar com.hadoop.compression.lzo.DistributedLzoIndexer -Dmapreduce.job.queuename=hive /warehouse/gmall/ods/ods_log/dt=$do_date

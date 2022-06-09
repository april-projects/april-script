#!/bin/bash

#获取运行天数,如果脚本第二个参数输入就用$2,如果不输入默认为10天
if [ -n "$2" ] ;then
	days=$2
else
	days=10
fi

#获取起始日期
start=$1

#定义函数,动态修改日志生成配置文件的日期
function createLogConfs()
{
logContent="logging.level.root=info\n
mock.date=$1\n
mock.startup.count=100\n
mock.max.mid=50\n
mock.max.uid=500\n
mock.max.sku-id=10\n
mock.page.during-time-ms=20000\n
mock.error.rate=3\n
mock.log.sleep=100\n
mock.detail.source-type-rate=40:25:15:20\n"

echo -e $logContent > /opt/module/applog/application.properties

xsync.sh /opt/module/applog/application.properties
}


for((i=0;i<$days;i++))
do
	do_date=$start
echo ------------------当前生成日志数据的日期:$do_date--------------------


	createLogConfs $do_date
	log.sh
	sleep 15s 
	start=`date -d "$start +1 day" +%F`
	
done 

echo ====================${days}天的日志数据全部采集到hdfs!====================

#!/bin/bash

#获取运行天数,如果脚本第二个参数输入就用$2,如果不输入默认为10天
if [ -n "$2" ] ;then
	days=$2
else
	days=10
fi

#获取起始日期
start=$1

#动态生成业务数据生成配置文件application.properties
function createconfs()
{
content="
logging.level.root=info\n
spring.datasource.driver-class-name=com.mysql.jdbc.Driver\n
spring.datasource.url=jdbc:mysql://alihadoop102:3306/gmall?characterEncoding=utf-8&useSSL=false&serverTimezone=GMT%2B8\n
spring.datasource.username=root\n
spring.datasource.password=123456\n
logging.pattern.console=%m%n\n
mybatis-plus.global-config.db-config.field-strategy=not_null\n
mock.date=$1\n
mock.clear=0\n
mock.user.count=1000\n
mock.user.male-rate=20\n
mock.user.update-rate:20\n
mock.favor.cancel-rate=10\n
mock.favor.count=100\n
mock.cart.count=30\n
mock.cart.sku-maxcount-per-cart=3\n
mock.cart.source-type-rate=60:20:10:10\n
mock.order.user-rate=95\n
mock.order.sku-rate=70\n
mock.order.join-activity=1\n
mock.order.use-coupon=1\n
mock.coupon.user-count=1000\n
mock.payment.rate=70\n
mock.payment.payment-type=30:60:10\n
mock.comment.appraise-rate=30:10:10:50\n
mock.refund.reason-rate=30:10:20:5:15:5:5\n
"
echo -e $content > /opt/module/db_log/application.properties

}


for((i=0;i<$days;i++))
do
	do_date=$start
echo ------------------当前生成业务数据日期:$do_date--------------------


	createconfs $do_date
	cd /opt/module/db_log
	java -jar gmall2020-mock-db-2020-04-01.jar
	gmall_mysql_to_hdfs.sh all $do_date
	start=`date -d "$start +1 day" +%F`
done 

echo ====================${days}天的业务数据全部采集到hdfs!====================

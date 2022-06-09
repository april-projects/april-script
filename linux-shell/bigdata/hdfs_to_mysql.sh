#!/bin/bash
hive_db_name=gmall
mysql_db_name=gmall_report

export_data() {
/opt/module/sqoop/bin/sqoop export \
-Dmapreduce.job.queuename=hive \
--connect "jdbc:mysql://alihadoop102:3306/${mysql_db_name}?useUnicode=true&characterEncoding=utf-8"  \
--username root \
--password 123456 \
--table $1 \
--num-mappers 1 \
--export-dir /warehouse/$hive_db_name/ads/$1 \
--input-fields-terminated-by "\t" \
--update-mode allowinsert \
--update-key $2 \
--input-null-string '\\N'    \
--input-null-non-string '\\N'
}

case $1 in
  "ads_user_topic")
     export_data "ads_user_topic" "dt"
;;
  "ads_area_topic")
     export_data "ads_area_topic" "dt,iso_code"
;;
   "all")
     export_data "ads_user_topic" "dt"
     export_data "ads_area_topic" "dt,iso_code"
     #其余表省略未写
;;
esac

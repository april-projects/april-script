#!/bin/bash
hive="/opt/module/hive-3.1.2-spark-3.0/bin/hive"

if [ -n "$1" ] ; then
	do_date=$1
else
	do_date=`date -d "-1 day" +%F`
fi

sql="
use gmall;
SET mapreduce.job.queuename=hive;
SET hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;

insert overwrite table dwd_start_log partition (dt='$do_date')
select
get_json_object(line,'$.common.ar'),
get_json_object(line,'$.common.ba'),
       get_json_object(line,'$.common.ch'),
       get_json_object(line,'$.common.md'),
       get_json_object(line,'$.common.mid'),
       get_json_object(line,'$.common.os'),
       get_json_object(line,'$.common.uid'),
       get_json_object(line,'$.common.vc'),
get_json_object(line,'$.start.entry'),
get_json_object(line,'$.start.loading_time'),
       get_json_object(line,'$.start.open_ad_id'),
       get_json_object(line,'$.start.open_ad_ms'),
       get_json_object(line,'$.start.open_ad_skip_ms'),
       get_json_object(line,'$.ts')
from ods_log where dt='$do_date' and get_json_object(line,'$.start') is not null;

insert overwrite table dwd_page_log partition (dt='$do_date')
select
get_json_object(line,'$.common.ar'),
    get_json_object(line,'$.common.ba'),
    get_json_object(line,'$.common.ch'),
    get_json_object(line,'$.common.md'),
    get_json_object(line,'$.common.mid'),
    get_json_object(line,'$.common.os'),
    get_json_object(line,'$.common.uid'),
    get_json_object(line,'$.common.vc'),
    get_json_object(line,'$.page.during_time'),
    get_json_object(line,'$.page.item'),
    get_json_object(line,'$.page.item_type'),
    get_json_object(line,'$.page.last_page_id'),
    get_json_object(line,'$.page.page_id'),
    get_json_object(line,'$.page.sourceType'),
    get_json_object(line,'$.ts')
from ods_log where dt = '$do_date' and get_json_object(line,'$.page') is not null;


insert overwrite table dwd_action_log partition (dt='$do_date')
select
get_json_object(line,'$.common.ar'),
    get_json_object(line,'$.common.ba'),
    get_json_object(line,'$.common.ch'),
    get_json_object(line,'$.common.md'),
    get_json_object(line,'$.common.mid'),
    get_json_object(line,'$.common.os'),
    get_json_object(line,'$.common.uid'),
    get_json_object(line,'$.common.vc'),
    get_json_object(line,'$.page.during_time'),
    get_json_object(line,'$.page.item'),
    get_json_object(line,'$.page.item_type'),
    get_json_object(line,'$.page.last_page_id'),
    get_json_object(line,'$.page.page_id'),
    get_json_object(line,'$.page.sourceType'),
    get_json_object(action,'$.action_id'),
    get_json_object(action,'$.item'),
    get_json_object(action,'$.item_type'),
    get_json_object(action,'$.ts')
from ods_log
lateral view explode_json_array(get_json_object(line,'$.actions')) tmp1 as action
where dt='$do_date' and get_json_object(line,'$.actions') is not null;

insert overwrite table dwd_display_log partition (dt='$do_date')
select
get_json_object(line,'$.common.ar'),
    get_json_object(line,'$.common.ba'),
    get_json_object(line,'$.common.ch'),
    get_json_object(line,'$.common.md'),
    get_json_object(line,'$.common.mid'),
    get_json_object(line,'$.common.os'),
    get_json_object(line,'$.common.uid'),
    get_json_object(line,'$.common.vc'),
    get_json_object(line,'$.page.during_time'),
    get_json_object(line,'$.page.item'),
    get_json_object(line,'$.page.item_type'),
    get_json_object(line,'$.page.last_page_id'),
    get_json_object(line,'$.page.page_id'),
    get_json_object(line,'$.page.sourceType'),
    get_json_object(line,'$.ts'),
    get_json_object(display,'$.displayType'),
    get_json_object(display,'$.item'),
    get_json_object(display,'$.item_type'),
    get_json_object(display,'$.order')
 from ods_log
lateral view explode_json_array(get_json_object(line,'$.displays')) tmp2 as display
where dt = '$do_date'
and get_json_object(line,'$.displays') is not null;

insert overwrite table dwd_error_log partition (dt='$do_date')
select
    get_json_object(line,'$.common.ar'),
    get_json_object(line,'$.common.ba'),
    get_json_object(line,'$.common.ch'),
    get_json_object(line,'$.common.md'),
    get_json_object(line,'$.common.mid'),
    get_json_object(line,'$.common.os'),
    get_json_object(line,'$.common.uid'),
    get_json_object(line,'$.common.vc'),
    get_json_object(line,'$.page.item'),
    get_json_object(line,'$.page.item_type'),
    get_json_object(line,'$.page.last_page_id'),
    get_json_object(line,'$.page.page_id'),
    get_json_object(line,'$.page.sourceType'),
    get_json_object(line,'$.start.entry'),
    get_json_object(line,'$.start.loading_time'),
    get_json_object(line,'$.start.open_ad_id'),
    get_json_object(line,'$.start.open_ad_ms'),
    get_json_object(line,'$.start.open_ad_skip_ms'),
    get_json_object(line,'$.actions'),
    get_json_object(line,'$.displays'),
    get_json_object(line,'$.ts'),
    get_json_object(line,'$.err.error_code'),
    get_json_object(line,'$.err.msg')
from ods_log where dt='$do_date' and get_json_object(line,'$.err') is not null;
"
$hive -e "$sql"

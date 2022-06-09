#!/bin/bash
hive=/opt/module/hive-3.1.2-spark-3.0/bin/hive
sql1="
use gmall;
set mapreduce.job.queuename=hive;
set hive.exec.dynamic.partition.mode=nonstrict;
SET hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;
insert overwrite table dwd_fact_order_detail partition (dt='2020-06-14')
select
      t1.id,
       t1.order_id,
       t1.user_id,
       t1.sku_id,
       t1.sku_name,
       t1.order_price,
       t1.sku_num,
       t1.create_time,
       t1.province_id,
       t1.source_type,
       t1.source_id,
t1.original_amount_d,
if(rn=1,final_total_amount-(sum_div_final_amount-final_amount_d),final_amount_d),
    if(rn=1,feight_fee-(sum_div_feight_fee-feight_fee_d),feight_fee_d),
    if(rn=1,benefit_reduce_amount-(sum_div_benefit_reduce_amount-benefit_reduce_amount_d),benefit_reduce_amount_d)
from
     (
        select
        od.id,
       od.order_id,
       od.user_id,
       od.sku_id,
       od.sku_name,
       od.order_price,
       od.sku_num,
       od.create_time,
       oi.province_id,
       od.source_type,
       od.source_id,
	 round(od.order_price*od.sku_num,2) original_amount_d,
        round(od.order_price*od.sku_num/oi.original_total_amount*oi.final_total_amount,2) final_amount_d,
        round(od.order_price*od.sku_num/oi.original_total_amount*oi.feight_fee,2) feight_fee_d,
        round(od.order_price*od.sku_num/oi.original_total_amount*oi.benefit_reduce_amount,2) benefit_reduce_amount_d,
        row_number() over(partition by od.order_id order by od.id desc) rn,
        oi.final_total_amount,
        oi.feight_fee,
        oi.benefit_reduce_amount,
        sum(round(od.order_price*od.sku_num/oi.original_total_amount*oi.final_total_amount,2)) over(partition by od.order_id) sum_div_final_amount,
        sum(round(od.order_price*od.sku_num/oi.original_total_amount*oi.feight_fee,2)) over(partition by od.order_id) sum_div_feight_fee,
        sum(round(od.order_price*od.sku_num/oi.original_total_amount*oi.benefit_reduce_amount,2)) over(partition by od.order_id) sum_div_benefit_reduce_amount
from
     (
        select * from ods_order_detail where dt='2020-06-14'
     ) od
     join
    (
        select * from ods_order_info where dt='2020-06-14'
    ) oi
    on od.order_id = oi.id
    )t1;
" 
$hive -e "$sql1"


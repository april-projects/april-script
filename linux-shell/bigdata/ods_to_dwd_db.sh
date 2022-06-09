#!/bin/bash
hive=/opt/module/hive-3.1.2-spark-3.0/bin/hive
if [ -n "$2" ] ; then
	do_date=$2
else
	do_date=`date -d "-1 day" +%F`
fi


sql1="
use gmall;
set mapreduce.job.queuename=hive;
set hive.exec.dynamic.partition.mode=nonstrict;
SET hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;

insert overwrite table dwd_dim_sku_info partition (dt='$do_date')
select
sku.id as id,
       sku.spu_id,
       sku.price,
       sku.sku_name,
       sku.sku_desc,
       sku.weight,
       sku.tm_id,
       tm.tm_name,
       sku.category3_id,
       c3.category2_id,
       c2.category1_id,
       c3.name as category3_name,
       c2.name as category2_name,
       c1.name as category1_name,
       spu.spu_name,
       sku.create_time
from ods_sku_info sku left join ods_spu_info spu on sku.spu_id = spu.id
left join ods_base_trademark tm on sku.tm_id = tm.tm_id
left join ods_base_category3 c3 on sku.category3_id = c3.id
left join ods_base_category2 c2 on c3.category2_id = c2.id
left join ods_base_category1 c1 on c2.category1_id = c1.id
where sku.dt = '$do_date' and spu.dt = '$do_date'
and tm.dt = '$do_date'
and c3.dt = '$do_date'
and c2.dt = '$do_date'
and c1.dt = '$do_date';


insert overwrite table dwd_dim_coupon_info partition (dt='$do_date')
select
id,coupon_name,coupon_type,condition_amount,condition_num,
       activity_id,benefit_amount,benefit_discount,
       create_time,range_type,spu_id,tm_id,category3_id,
       limit_num,operate_time,expire_time
from ods_coupon_info where dt='$do_date';


insert overwrite table dwd_dim_activity_info partition (dt='$do_date')
select
id, activity_name, activity_type, start_time, end_time, create_time
from ods_activity_info where dt='$do_date';

insert overwrite table dwd_fact_order_detail partition (dt='$do_date')
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
if(t1.rk=1,t1.final_total_amount-t1.final_amount_d_sum+final_amount_d,t1.final_amount_d) as final_amount_d,
if(t1.rk=1,t1.feight_fee-t1.feight_fee_d_sum+t1.feight_fee_d,t1.feight_fee_d) as feight_fee_d ,
if(t1.rk=1,t1.benefit_reduce_amount-t1.benefit_reduce_amount_d_sum+t1.benefit_reduce_amount_d,t1.benefit_reduce_amount_d) as benefit_reduce_amount_d
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
        oi.final_total_amount,
        oi.feight_fee,
               oi.benefit_reduce_amount,
       ROUND(od.sku_num*od.order_price,2) as original_amount_d,-- 原始价格分摊
       ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.final_total_amount,2) as final_amount_d,--购买价格分摊
        ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.feight_fee,2) as feight_fee_d,-- 运费分担
        ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.benefit_reduce_amount,2) as benefit_reduce_amount_d, -- 优惠分担
        sum(ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.final_total_amount,2))  over(partition by od.order_id) as final_amount_d_sum,--购买价格分摊总和
        sum(ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.feight_fee,2)) over(partition by od.order_id) as feight_fee_d_sum,--运费分摊总和
        sum(ROUND((od.sku_num*od.order_price/oi.original_total_amount)*oi.benefit_reduce_amount,2)) over(partition by od.order_id) as benefit_reduce_amount_d_sum,--运费分摊总和
        rank() over(partition by od.order_id order by oi.original_total_amount desc) as rk
from
     (
        select * from ods_order_detail where dt='$do_date'
     ) od
     join
    (
        select * from ods_order_info where dt='$do_date'
    ) oi
    on od.order_id = oi.id
    )t1;


insert overwrite table dwd_fact_payment_info partition (dt='$do_date')
select
opi.id,
       opi.out_trade_no,
       opi.order_id,
       opi.user_id,
       opi.alipay_trade_no,
       opi.total_amount as payment_amount,
       opi.subject,
       opi.payment_type,
       opi.payment_time,
       ooi.province_id
from ods_payment_info opi left join ods_order_info ooi on opi.order_id = ooi.id
 where opi.dt = '$do_date' and ooi.dt='$do_date';

insert overwrite table dwd_fact_order_refund_info partition (dt='$do_date')
select
id,user_id,order_id,sku_id,refund_type,refund_num,
       refund_amount,refund_reason_type,create_time
from ods_order_refund_info where dt='$do_date';

insert overwrite table dwd_fact_comment_info partition (dt='$do_date')
select
id,user_id,sku_id,spu_id,order_id,appraise,create_time
from ods_comment_info where dt='$do_date';



insert overwrite table dwd_fact_coupon_use partition (dt)
select
nvl(new.id,old.id),
       nvl(new.coupon_id,old.coupon_id),
       nvl(new.user_id,old.user_id),
       nvl(new.order_id,old.order_id),
       nvl(new.coupon_status,old.coupon_status),
       nvl(new.get_time,old.get_time),
       nvl(new.using_time,old.using_time),
       nvl(new.used_time,old.used_time),
       date_format(nvl(new.get_time,old.get_time),'yyyy-MM-dd')
from
(
select id,
       coupon_id,
       user_id,
       order_id,
       coupon_status,
       get_time,
       using_time,
       used_time
from ods_coupon_use where dt='$do_date'
    )  new

full join

(
            select
               id,
               coupon_id,
               user_id,
               order_id,
               coupon_status,
               get_time,
               using_time,
               used_time
        from dwd_fact_coupon_use
         where dt in (
             select date_format(ods_coupon_use.get_time,'yyyy-MM-dd') from ods_coupon_use
             where dt = '$do_date'
        )
) old
on new.id = old.id;

insert overwrite table dwd_fact_cart_info partition (dt='$do_date')
select id,
       user_id,
       sku_id,
       cart_price,
       sku_num,
       sku_name,
       create_time,
       operate_time,
       is_ordered,
       order_time,
       source_type,
       source_id
from ods_cart_info where dt='$do_date';


insert overwrite table dwd_fact_favor_info partition (dt='$do_date')
select id,
       user_id,
       sku_id,
       spu_id,
       is_cancel,
       create_time,
       cancel_time
from ods_favor_info where dt='$do_date';


insert overwrite table dwd_fact_order_info partition (dt)
select
    if(new.id is not null,new.id,old.id),
    if(new.order_status is not null,new.order_status,old.order_status),
    if(new.user_id is not null,new.user_id,old.user_id),
    if(new.out_trade_no is not null,new.out_trade_no,old.out_trade_no),
    if(new.create_time is not null,new.create_time,old.create_time),
    nvl(new.payment_time,old.payment_time),
    nvl(new.cancel_time,old.cancel_time),
    nvl(new.finish_time,old.finish_time),
    nvl(new.refund_time,old.refund_time),
    nvl(new.refund_finish_time,old.refund_finish_time),
    nvl(new.province_id,old.province_id),
    nvl(new.activity_id,old.activity_id),
    nvl(new.original_total_amount,old.original_total_amount),
    nvl(new.benefit_reduce_amount,old.benefit_reduce_amount),
    nvl(new.feight_fee,old.feight_fee),
    nvl(new.final_total_amount,old.final_total_amount),
    date_format(nvl(new.create_time,old.create_time),'yyyy-MM-dd')
from
(
    select * from dwd_fact_order_info ofoi where dt in
    (
        select date_format(create_time,'yyyy-MM-dd') from ods_order_info where dt = '$do_date'
    )
) new
full join
(
    select
    ooi.id,
       ooi.order_status,
       ooi.user_id,
       ooi.out_trade_no,
       oosl.stm['1001'] as create_time,
       oosl.stm['1002'] as payment_time,
       oosl.stm['1003'] as cancel_time,
       oosl.stm['1004'] as finish_time,
       oosl.stm['1005'] as refund_time,
       oosl.stm['1006'] as refund_finish_time,
       ooi.province_id,
       oao.activity_id,
       ooi.original_total_amount,
       ooi.benefit_reduce_amount,
       ooi.feight_fee,
       ooi.final_total_amount
    from
    (
    select id,
           final_total_amount,
           order_status,
           user_id,
           out_trade_no,
           create_time,
           operate_time,
           province_id,
           benefit_reduce_amount,
           original_total_amount,
           feight_fee
    from ods_order_info
    where dt = '$do_date'
    ) ooi
    join
    (
    select order_id,str_to_map(concat_ws(',',collect_list(concat_ws('=',order_status,operate_time))),',','=') stm
        from  ods_order_status_log where dt='$do_date' group by order_id
    ) oosl
    on ooi.id = oosl.order_id

    left join
    (
    select id, activity_id, order_id, create_time, dt
    from ods_activity_order where dt = '$do_date'
    ) oao
    on ooi.id = oao.order_id
) old
on new.id = old.id;
"


sql2="
use gmall;
insert overwrite table dwd_dim_base_province
select
    obp.id,
    obp.name as province_name,
    obp.area_code,
    obp.iso_code,
    obr.id as region_id,
    obr.region_name
from ods_base_province obp
left join ods_base_region obr
on obp.region_id = obr.id;
"

sql3="
use gmall;
insert overwrite table dwd_dim_user_info_his
select * from
(
   select
        id,
        name,
        birthday,
        gender,
        email,
        user_level,
        create_time,
        operate_time,
        '$do_date' as start_date,
        '9999-99-99' as end_date
    from ods_user_info where dt='$do_date'
union all
    select
       old.id,
       old.name,
       old.birthday,
       old.gender,
       old.email,
       old.user_level,
       old.create_time,
       old.operate_time,
       old.start_date,
       if(old.id is not null and old.end_date='9999-99-99',date_add(new.dt,-1),old.end_date)end_date
    from dwd_dim_user_info_his old
    left join ods_user_info new on old.id = new.id where new.dt='$do_date' and old.start_date<'$do_date'
) his
order by cast(his.id as bigint),his.start_date
"
case $1 in
"first"){
    $hive -e "$sql1$sql2"
};;
"all"){
    $hive -e "$sql1$sql3"
};;
esac

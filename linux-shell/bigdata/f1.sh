#! /bin/bash
case $1 in
"start"){
        for i in alihadoop101 alihadoop102
        do
                echo " --------启动 $i 采集flume-------"
                ssh $i "nohup /opt/module/flume-1.9.0/bin/flume-ng agent -c /opt/module/flume-1.9.0/conf -f /opt/module/flume-1.9.0/job/file-flume-kafka.conf -n a1 -Dflume.root.logger=INFO,LOGFILE >/opt/module/flume-1.9.0/log1.txt 2>&1  &"
        done
};;	
"stop"){
        for i in alihadoop101 alihadoop102
        do
                echo " --------停止 $i 采集flume-------"
                ssh $i "ps -ef | grep file-flume-kafka | grep -v grep |awk  '{print \$2}' | xargs -n1 kill -9 "
        done

};;
esac

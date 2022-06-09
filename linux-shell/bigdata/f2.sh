#! /bin/bash
case $1 in
"start"){
        for i in alihadoop103
        do
                echo " --------启动 $i 消费flume-------"
                ssh $i "nohup /opt/module/flume-1.9.0/bin/flume-ng agent -c conf -f /opt/module/flume-1.9.0/job/kafka-flume-hdfs.conf -n a1 -Dflume.root.logger=INFO,LOGFILE >/opt/module/flume-1.9.0/log2.txt 2>&1 &"
        done
};;
"stop"){
        for i in alihadoop103
        do
                echo " --------停止 $i 消费flume-------"
                ssh $i "ps -ef | grep kafka-flume-hdfs | grep -v grep |awk '{print \$2}' | xargs -n1 kill"
        done

};;
esac

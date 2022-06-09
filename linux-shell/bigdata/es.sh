#!/bin/bash
es_home=/opt/module/elasticsearch-6.6.0
case $1  in
 "start") {
  for i in alihadoop101 alihadoop102 alihadoop103
  do
    echo "==============$i=============="
ssh $i  "source /etc/profile;${es_home}/bin/elasticsearch >/dev/null 2>&1 &"
sleep 4s;
  done

};;
"stop") {
  for i in alihadoop101 alihadoop102 alihadoop103
  do
    echo "==============$i=============="
    ssh $i "ps -ef|grep $es_home |grep -v grep|awk '{print \$2}'|xargs kill" >/dev/null 2>&1
  done

};;
esac


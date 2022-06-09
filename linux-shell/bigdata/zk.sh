#!/bin/bash
if [ $# -lt 1 ]
then
  echo "Input Args Error....."
  exit
fi
for i in alihadoop101 alihadoop102 alihadoop103
do

case $1 in
start)
  echo "==================START $i ZOOKEEPER==================="
  ssh $i /opt/module/zookeeper-3.5.7/bin/zkServer.sh start
;;
stop)
  echo "==================STOP $i KAFKA==================="
  ssh $i /opt/module/zookeeper-3.5.7/bin/zkServer.sh stop
;;
status)
  echo "==================STOP $i KAFKA==================="
  ssh $i /opt/module/zookeeper-3.5.7/bin/zkServer.sh status
;;

*)
 echo "Input Args Error....."
 exit
;;
esac

done


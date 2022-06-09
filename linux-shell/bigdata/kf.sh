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
  echo "==================START $i KAFKA==================="
  ssh $i /opt/module/kafka/bin/kafka-server-start.sh -daemon /opt/module/kafka/config/server.properties
;;
stop)
  echo "==================STOP $i KAFKA==================="
  ssh $i /opt/module/kafka/bin/kafka-server-stop.sh stop
;;

*)
 echo "Input Args Error....."
 exit
;;
esac

done

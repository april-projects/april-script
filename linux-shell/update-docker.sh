#!/bin/sh

echo "------开始更新------"

docker stop tomcat

mv /docker/tomcat/bulid/tomcat/webapps/ROOT.war /docker/tomcat/bulid/tomcat/webapps/ROOT.war.old

rm -rf /docker/tomcat/bulid/tomcat/webapps/ROOT

mv ./*.war /docker/tomcat/bulid/tomcat/webapps/ROOT.war

docker start tomcat

echo "------更新完毕------"

sleep 3s

docker logs --tail 500 -f tomcat;

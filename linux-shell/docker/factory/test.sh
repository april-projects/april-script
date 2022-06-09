#!/bin/bash
app=test1
post=8080
docker stop $app
docker rm $app
cp ~/docker/factory/temp/summer-sample/target/sample-1.2.1.war ~/docker/factory/temp/webapps/ROOT.war
docker run -d --name $app -p $port:8080 -h $app -v ~/docker/factory/temp/webapps:/opt/tomcat/webapps summer/tomcat
docker exec -it $app /bin/bash

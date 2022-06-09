#!/bin/bash
app=$1

cd ~

sudo docker stop $app

rm -rf tomcats/$app/webapps/ROOT
rm -rf tomcats/$app/webapps/ROOT.war

cp ~/app-1.0.0.war tomcats/$app/webapps/ROOT.war

sudo docker start $app

sudo docker logs --tail 200 -f $app

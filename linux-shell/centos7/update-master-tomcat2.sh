#!/bin/bash

#打包服务器IP
#IP=47.52.33.155
IP=10.30.68.98

#来源项目运行路径
baseProjectPath=/var/lib/docker/aufs/diff/af7ecddc21e9c22e38521910e69de3e31533d0720a4f72ec6c1a50a370a1e12a/var/jenkins_home/workspace/miuzu-master/target/
#来源项目的名称
baseProjectName=mojinpai-1.0.0.war

#指向路径
toProjectPath=~/docker/tomcat/tomcat-2/webapps/ 	

#指向路径下的WAR包名称
toProjectName=mojinpai-new.war

#开始获取打包完毕的WAR包
scp root@$IP:$baseProjectPath$baseProjectName $toProjectPath$toProjectName

cd $toProjectPath

cp $toProjectPath/mojinpai.war $toProjectPath/mojinpai.war.bak

if [ "$?" -ne 0 ]
then
        echo "bak is fail,stop-update"
        exit 1
fi

echo [info]----------备份成功------------------------

#停止tomcat2
echo "----通知tomcat2服务----"
docker stop tomcat-2
#修改WAR包文件名称
mv $toProjectName mojinpai.war

#重启tomcat2名称
docker restart tomcat-2

#服务tomcat-1下的jar包到tomcat的项目下
#cp ~/docker-project/Uzu/tomcat-1/webapps/mojinpai/WEB-INF/lib/* ~/docker-project/Uzu/tomcat-2/webapps/mojinpai/WEB-INF/lib


#验证tomcat2是否重启成功
WEBSITE=http://47.91.199.171:8082/forms/FrmLogin

stat='true'
CODE=1
i=1
while($stat)
do
        CODE=`curl -I -s $WEBSITE | head -1 | cut -d " " -f2`

        echo [info]------------------------------------------
        echo [info]----------等待中。。。--------------------
        echo [info]------------------------------------------
        sleep 10s
        if [ "$CODE" == 200 ]
        then
                stat='false'
        fi
done
echo [info]------------------------------------------
echo [info]----------docker-2更新完毕----------------
echo [info]------------------------------------------





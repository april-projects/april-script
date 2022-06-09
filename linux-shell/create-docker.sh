#!/bin/sh

#文件下载地址
basePathDownload=http://pro-docker-file.oss-cn-shenzhen.aliyuncs.com/Dockerfile-file

#tomcat镜像地址
tomcatPathImages=/tomcat/tomcat-1.8/Dockerfile
tomcatConf=/tomcat/tomcat-1.8/tomcat.zip
timeFile=/tomcat/tomcat-1.8/localtime
#文件存放路径
dockerFile=/docker/tomcat/bulid

#参数:tomcat镜像文件
tomcatImagesName=tomcat-1.8
#tomcatp配置信息
tomcatName=tomcat
tomcatPort=80
tomcatMem=2048

echo start install docker-tomcat

#检测docker是否安装,没有就先安装
docker --version 2>/dev/null

if [ $? -eq 0 ]
then
	echo "YES"
else
	apt-get update
	apt-get install -y docker.io
fi



#下载dockerfile安装镜像
#先docker文件夹
if [ ! -d "${dockerFile}" ];then
mkdir -p ${dockerFile}
else
echo "file is exist"
fi
cd $dockerFile
wget ${basePathDownload}${tomcatPathImages}
wget ${basePathDownload}${timeFile}

#docker bulid文件新建镜像
docker build -t ${tomcatImagesName} ./

#安装启动docker
#新建tomcat容器
wget ${basePathDownload}${tomcatConf}
apt-get install -y zip
unzip tomcat.zip
cd ${dockerFile}/tomcat
#文件挂载路径
webapps=$PWD/webapps
conf=$PWD/conf
docker run --name $tomcatName -p ${tomcatPort}:80 --restart always  -v $webapps:/opt/webserver/webapps -v $conf:/opt/webserver/conf  -d  ${tomcatImagesName}

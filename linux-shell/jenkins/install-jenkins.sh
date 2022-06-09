#/bin/bash

# 删除容器
docker stop jenkins
docker rm jenkins

# 删除镜像
docker rmi jenkins/jenkins:lts

# 创建容器
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
--restart=always \
-v /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime \
-v jenkins_home:/var/jenkins_home \
-e JAVA_OPTS=-Duser.timezone=Asia/Shanghai jenkins/jenkins:lts

#!/bin/bash

# 拉取官方最新的 tomcat 镜像
docker pull tomcat

# 建立一个临时的容器 tomcat 
docker run --name tomcat -d --rm tomcat

# 进入 tomcat 容器查看文件位置
docker exec -it tomcat /bin/bash

# 拷贝容器文件到宿主主机
docker cp tomcat:/usr/local/tomcat /usr/local/tomcat

# 删除临时容器
docker stop tomcat

# tomcat_8101
cp -r /usr/local/tomcat /usr/local/tomcat_master_8101
docker run --name tomcat_master_8101 -p 8101:8080 -d --restart=always -v /usr/local/tomcat_master_8101:/usr/local/tomcat tomcat
docker logs --tail 2000 -f tomcat_master_8101

# tomcat_8101
cp -r /usr/local/tomcat /usr/local/tomcat_master_8102
docker run --name tomcat_master_8102 -p 8102:8080 -d --restart=always -v /usr/local/tomcat_master_8102:/usr/local/tomcat tomcat
docker logs --tail 2000 -f tomcat_master_8102

# 时区设置

# session 共享
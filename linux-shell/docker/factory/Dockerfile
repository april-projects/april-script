FROM docker.io/dordoka/tomcat
MAINTAINER cn.cerc.summer

#RUN apt-get update 

# 设置时区
ENV TIME_ZONE Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
RUN echo ${TIME_ZONE} > /etc/timezone

# synac with memcached
ADD tomcat-lib/*.jar /opt/tomcat/lib/
ADD tomcat-conf/*.* /opt/tomcat/conf/

# add crypt with uzu
ADD crypt/*.jar /usr/lib/jvm/java-8-oracle/jre/lib/security/

EXPOSE 8080

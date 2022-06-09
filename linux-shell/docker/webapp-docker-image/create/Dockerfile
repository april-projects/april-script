FROM tomcat:9.0

# 设置时区
ENV TIME_ZONE Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
RUN echo ${TIME_ZONE} > /etc/timezone
ENV JAVA_OPTS "-Djava.security.egd=file:/dev/./urandom"

# 构建应用
RUN rm -rf /usr/local/tomcat/webapps/ROOT/
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

# 拷贝配置
COPY summer-application.properties /root/
COPY IP_trial_single_WGS84.awdb /root/

# 暴露端口
EXPOSE 8080

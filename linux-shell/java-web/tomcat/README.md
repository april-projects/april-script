# Tomcat部署

## 自动部署

```
wget -O auto-build.sh https://gitee.com/mimrc/summer-install/raw/develop/java-web/tomcat/auto-build.sh -O - | sh
```

## 性能优化

```
# java
# update java security 117 行
cd /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security
vim java.security

# tomcat 

# 设置静态资源缓存
vim conf/context.xml
<Resources cachingAllowed="true" cacheMaxSize="102400" />

cd /root/tomcats/app8101/bin
vim catalina.sh

# 设置运行时区
export JAVA_OPTS="$JAVA_OPTS -Duser.timezone=Asia/shanghai"

# 设置虚拟机内存
JAVA_OPTS='-server -Xms2048m -Xmx2048m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:SurvivorRatio=8'

```

### 使用说明

1. 拷贝文件到root目录

```
cd
cp summer-install/java/tomcat/* .
```

2. 解压压缩文件

```
tar -zxvf tomcat.tgz
```

3. 更改tomcat名字

```
mv tomcat app8101
```

4. 创建public文件夹

```
mkdir public
```

5. 更改public权限

```
chmod 755 public
```

6. 上传war包

7. 更改war包

```
vim update.sh
```

更改war包名字

8. 安装jdk8

使用javac查看安装命令

```
apt install openjdk-8-jdk-headless -y
```

9. 安装Redis

```
apt install redis-server -y
```

10. 启动Redis

```
/etc/init.d/redis-server restart
```

测试redis是否可以连接
```
redis-cli 
```

11. 安装memcached

```
apt install memcached -y
```

测试 memcached 是否可以连接
```
telnet 127.0.0.1 11211
```

退出
```
quit
```

12. 安装nginx

```
apt install nginx-full -y
```

测试nginx是否启动了

13. 添加nginx配置

```
cd /etc/nginx/conf.d
vim app.conf
```

14. 创建tomcat实例

```
sh update.sh app8101
```

如需部署tomcat8102端口则需要再次解压tomcat.tgz

更改tomcat名字为app8102

进入app8102更改server.xml中的端口

再次创建tomcat实例

```
sh update.sh app8102
```

15. 测试8101端口

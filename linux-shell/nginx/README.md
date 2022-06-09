# Nginx 配置说明

1、复制一份文件到主机的 /etc/nginx/conf.d 目录下

2、根据实际情况修改主机池的服务器ip和端口 upstream

3、将需要代理的域名替换掉 www.example.com

4、在 /etc/nginx/ 目录下创建 cert 目录，用来存放https的证书

5、若不需要开启http重定向到https，请注释掉http的重定向模块
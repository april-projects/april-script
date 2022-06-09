#!/usr/bin/python

import os
import sys
import time

def sh(cmd):
    print(cmd)
    os.system(cmd)

hosts = ['bourse', 'wallet', 'tw', 'wcm', 'aw', 'card']

i = 0
for app in hosts:

    # 创建物理文件夹
    sh("""mkdir tomcats""" )
    sh("""mkdir tomcats/%s""" % (app))
    sh("""mkdir tomcats/%s/webapps""" % (app))
    sh("""mkdir tomcats/%s/logs""" % (app))
    sh("""mkdir tomcats/%s/root""" % (app))

    # 拷贝tomcat配置
    sh("""cp -R ~/summer-install/docker/factory/tomcat-conf/ ~/tomcats/%s/conf/""" % (app))

    # 创建应用docker
    i = i + 1
    port = 8080 + i
    sh("""docker stop %s-app && docker rm %s-app""" % (app, app))
#    sh("""docker run -d --name %s-app -p %s:8080 --restart=always -h %s --link=%s-redis:redis \
    sh("""docker run -d --name %s-app -p %s:8080 --restart=always -h %s \
        -v ~/tomcats/%s/webapps:/opt/tomcat/webapps \
        -v ~/tomcats/%s/conf:/opt/tomcat/conf \
        -v ~/tomcats/%s/logs:/opt/tomcat/logs \
        -v ~/tomcats/%s/root:/root \
        summer/tomcat""" % (app, port, app,
        app, app, app, app))

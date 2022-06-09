#!/usr/bin/python

import os
import sys
import time

warfile = '/root/coa-app.war'

def sh(cmd):
    print(cmd)
    os.system(cmd)

def createFile(filename, context):
	if os.path.exists(filename):
		os.remove(filename)
	print("create file: %s" % filename)
	fc = open(filename, 'w')
	fc.write('# create by python\n')
	fc.write(context)
	fc.close()

	
class Tomcat:
    def __init__(self, app, port):
        self.app = app
        self.port = port
        self.conf = '/root/tomcats/%s/root/summer-application.properties' % app
        sh('docker stop %s' % app)
        sh('docker rm %s' % app)
	
    def update(self):
        os.chdir('/root')
        sh('mkdir tomcats')
        sh('mkdir tomcats/%s' % self.app)
        sh('mkdir tomcats/%s/webapps' % self.app)
        sh('mkdir tomcats/%s/logs' % self.app)
        sh('mkdir tomcats/%s/root' % self.app)
        
        createFile(self.conf, 'Domain=http://%s.coacoin.net\nOSS=http://%s.coacoin.net\n' % (self.app, self.app))

        sh('cp %s ~/tomcats/%s/webapps/ROOT.war' % (warfile, self.app))
        sh('cp -R ~/summer-install/docker/factory/tomcat-conf/ ~/tomcats/%s/conf/' % self.app)

        sh("""docker run -d --name %s -p %s:8080 -h %s \
    	    -v ~/tomcats/%s/webapps:/opt/tomcat/webapps \
    	    -v ~/tomcats/%s/conf:/opt/tomcat/conf \
    	    -v ~/tomcats/%s/logs:/opt/tomcat/logs \
            -v ~/tomcats/%s/root:/root \
    	    summer/tomcat""" % (self.app, self.port, self.app,\
            self.app, self.app, self.app, self.app))
	
        #sh('docker exec -it %s /bin/bash' % self.app)
        #sh('docker logs --tail 200 -f %s' % self.app)

    def createNginx(self):
        context = """
upstream %s{
  ip_hash;
  server 127.0.0.1:%s weight=1;
}

server {
    listen        80;
    server_name   %s.coacoin.net;
    root   /www;
    index  index.html index.htm;

    location / {
        proxy_pass http://%s;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        client_max_body_size 1000M;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /nginx/nginx_1;
    }
}""" % (self.app, self.port, self.app, self.app)
        createFile("/etc/nginx/conf.d/%s.conf" % self.app, context)

def build():
    sh('rm -rf /root/.m2/repository/cn/cerc')
    sh('rm -rf /root/.m2/repository/com/huagu')
    sh('rm -rf /root/.m2/repository/site/jayun')

    sh('git clone -b master https://gitee.com/hgwl/coa_project')

    os.chdir('/root/coa_project/coa-app')
    sh('mvn -P server clean package')
    sh('cp ~/coa_project/coa-app/target/coa-app-1.0.0.war ~/coa-app.war')

    #os.chdir('/root/coa_project/coa-quartz')
    #sh('mvn -P server clean package')
    #sh('cp /root/coa_project/coa-quartz/target/coa-quartz-1.0.0.war ~/coa-quartz.war')

    sh('rm -rf /root/coa_project')
    os.chdir('/root')
	
os.chdir('/root') #改变当前路径
print('current work directory: %s' % os.getcwd()) # 打印当前工作目录

menus = """****************** coa manage menus **************
a1: git & mvn package
b1: create docker tomcat(1...5)
c1: replace tomcats*.war
"""
hosts = ['www', 'beta', 'cdn']

if len(sys.argv) == 2:
    choice = sys.argv[1]
else:
    print(menus)
    choice = input("plese choice, other key to exit:")

if choice == 'a1':
    build()
if choice == 'b1':
    i = 0
    for item in hosts:
        i = i + 1
        tomcat = Tomcat(item, 8080 + i)
        tomcat.update()
        tomcat.createNginx()
    sh('nginx -s reload')
if choice == 'c1':
    for app in hosts:
        sh('docker stop %s' % app)
        sh('rm -rf /root/tomcats/%s/webapps/ROOT' % app)
        sh('rm -rf /root/tomcats/%s/webapps/ROOT.war' % app)     
        sh('cp %s /root/tomcats/%s/webapps/ROOT.war' % (warfile, app))
        sh('docker start %s' % app)








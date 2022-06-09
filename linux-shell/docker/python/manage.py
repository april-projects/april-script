#!/usr/bin/python

import os
import sys
import time

masterFile = 'b1:/d/webapp/workspace/vine-app-master/vine-app/target/vine-app-1.0.0.war'
developFile = 'b1:/d/webapp/workspace/vine-app-develop/vine-app/target/vine-app-1.0.0.war'

menus = """************************* docker manage menus *************************
a1: docker ps all        a2: docker stats        a3: view cpu & memory
b1: docker stop all      b2: docker start all    b3: docker restart all
c1: reset memcached     
d1: reset app[mast]      d2: update app[mast]    d3: check server app8101
e1: reset app[dev]       e2: update app[dev]     e3: check server app8201
h1: reset app task       h2: reset nginx         h3: vim manage.py(m)"""

class Tomcat:
    def __init__(self, warfile, groups):
        self.warfile = warfile
        self.groups = groups;
        self.maxMem = '2048m';

    def reset(self):
        for port in self.groups:
            self.resetApp(port)

    def update(self):
        for port in self.groups:
            self.updateApp(port)

    def show(self):
        sh('docker exec -it app%s /bin/bash' % self.groups[0])
   
    def resetApp(self, port):
        name = 'app%s' % port
        subPath = '/d/webapp/%s' % name
        sh('docker stop %s && docker rm %s' % (name, name))
        sh('rm -rf %s && mkdir %s' % (subPath, subPath))
        sh('mkdir %s/webapps' % subPath)
        sh('cp %s %s/webapps/ROOT.war'   % (self.warfile, subPath))
        sh("""docker run --name %s -p %s:8080 --restart=always -m %s \
            --link memcached:memcached_host \
            -v %s/webapps/:/opt/tomcat/webapps/ \
            -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime \
            -d summer/tomcat""" % (name, port, self.maxMem, subPath))
        print('')

    def updateApp(self, port):
        app = 'app%s' % port    
        sh('docker stop %s' % app)
        print('please wait 20s ...')
        time.sleep(10)
        sh('scp %s /d/webapp/%s/webapps/ROOT.war' % (self.warfile, app))
        sh('rm -rf /d/webapp/%s/webapps/ROOT/' % app)
        time.sleep(10)
        sh('docker start %s' % app)
        print('please wait 60s ...')
        time.sleep(60)
        print('finish')
        print('')

if len(sys.argv) == 2:
    choice = sys.argv[1]
else:
    print(menus)
    choice = input("please choice, other key to exit: ")

appMaster = Tomcat(masterFile, ['8101', '8102'])
appMaster.maxMem = '4096m'
appDevelop = Tomcat(developFile, ['8201', '8202'])
appDevelop.maxMem = '2048m'


#显示操作主菜单
def showMenus():
    groups = ['8101', '8102']
    
    if   choice == "a1":
        sh('docker ps -a')
    elif choice == 'a2':
        sh('docker stats')
    elif choice == 'a3':
        sh('top')


    elif choice == 'b1':
        sh('docker stop $(docker ps -q)')
    elif choice == 'b2':
        sh('docker start $(docker ps -a -q)')
    elif choice == 'b3':
        sh('docker restart $(docker ps -q)')

    elif choice == 'c1':
        sh('docker stop memcached && docker rm memcached')
        sh('docker run -d --name memcached -p 11211:11211 --restart=always -m 200m memcached')

    elif choice == 'd1':
        appMaster.reset()
    elif choice == 'd2':
        appMaster.update()
    elif choice == 'd3':
        appMaster.show()
    elif choice == 'e1':
        appDevelop.reset()
    elif choice == 'e2':
        appDevelop.update()
    elif choice == 'e3':
        appDevelop.show()

    elif choice == 'h1':
        updateTask()
    elif choice == 'h2':
        nginx = NginxConfig()
        nginx.start()
        nginx.addServers('a1.knowall.cn', groups, 'a-group')
        nginx.addServers('b.knowall.cn', groups, 'b-group')
        nginx.addServers('r1.knowall.cn', groups, 'r1-group')
        nginx.save()
        sh('nginx -s reload')
    elif choice == 'h3':
        sh('vim /d/manage.py')
    
#建立Nginx的sever.conf文件
class NginxConfig:
    def __init__(self):
        self.conf = '/etc/nginx/conf.d/sever.conf'
        #self.conf = 'd:\sever.conf'

    def start(self):
        if os.path.exists(self.conf):
            os.remove(self.conf)
        print("create nginx config: %s" % self.conf)
        self.fc = open(self.conf, 'w')
        self.fc.write('# create by NginxConfig.py')

    def save(self):
        self.fc.close()

    def addServers(self, host, servers, group):
        self.fc.write('\nupstream %s{\n' % group)
        for server in servers:
            self.fc.write('server localhost:%s;\n' % server)
        self.fc.write("}\n")
        self.fc.write("""
server {
        listen 80;
        server_name %s;
        keepalive_timeout 90;
        location / {
                proxy_read_timeout 90;
                proxy_pass http://%s/;
        }
}""" % (host, group))

    def write(self, site, port, host = 'localhost'):
        self.fc.write("""
server {
        listen 80;
        server_name %s;
        location / {
                proxy_pass http://%s:%s;
        }
}""" % (site, host, port))

def updateTask():
    taskFile = 'b1:/d/webapp/workspace/vine-task/vine-task/target/vine-task-1.0.0.war'
    sh('docker stop appTask && docker rm appTask')
    sh('rm -rf /d/webapp/appTask && mkdir /d/webapp/appTask')
    sh('mkdir /d/webapp/appTask/webapps')
    sh('scp %s /d/webapp/appTask/webapps/ROOT.war' % taskFile)
    sh("""docker run --name appTask -p 8401:8080 --restart=always -m 2048m \
       --link memcached:memcached_host \
       -v /d/webapp/appTask/webapps/:/opt/tomcat/webapps/ -d summer/tomcat""")
   

#运行命令行
def sh(cmd):
        print(cmd)
        os.system(cmd)
#开始运行
showMenus()

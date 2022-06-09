#!/bin/bash

# 方案一->内部快速拷贝
warfile='root@jenkins:/var/lib/docker/volumes/jenkins_home/_data/workspace/diaoyou-admin/diaoyou-admin/target/diaoyou-admin-1.0.0.war'
scp $warfile ~

# 方案二->远程下载文件
# wget -O diaoyou-admin-1.0.0.war https://jenkins.diteng.site/job/diaoyou-app/ws/diaoyou-admin/target/diaoyou-app-1.0.0.war

update_admin(){
    app=$1

    cd ~
    echo "docker stop $app."
    sudo docker stop $app

    rm -rf tomcats/$app/webapps/ROOT
    rm -rf tomcats/$app/webapps/ROOT.war

    cp ~/diaoyou-admin-1.0.0.war ~/tomcats/$app/webapps/ROOT.war 

    echo "docker start $app."
    sudo docker start $app

    echo "finish update admin $app."
}

update_admin admin8103

# 休息10秒等待缓存同步完成
sleep 10

update_admin admin8104
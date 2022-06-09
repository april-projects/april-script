#!/bin/bash

# 方案一->内部快速拷贝
warfile='root@jenkins:/var/lib/docker/volumes/jenkins_home/_data/workspace/diaoyou-task/diaoyou-task/target/diaoyou-task-1.0.0.war'
scp $warfile ~

# 方案二->远程下载文件
# wget -O diaoyou-admin-1.0.0.war https://jenkins.diteng.site/job/diaoyou-app/ws/diaoyou-app/target/diaoyou-app-1.0.0.war

update_task() {
    app=$1

    cd ~
    echo "docker stop $app."
    sudo docker stop $app

    rm -rf tomcats/$app/webapps/ROOT
    rm -rf tomcats/$app/webapps/ROOT.war

    cp ~/diaoyou-task-1.0.0.war tomcats/$app/webapps/ROOT.war

    echo "docker start $app."
    sudo docker start $app

    sudo docker logs --tail 200 -f $app
}

update_task task8105
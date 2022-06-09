#!/bin/bash
app=official-website

# 从 git 仓库下载更新内容
cd ~/www-zntieke-com

git pull

sudo docker stop $app

# 删除的文件内容
rm -rf tomcats/$app/webapps/ROOT/*

# 重新拷贝新内容
cp -r ~/www-zntieke-com/* ~/tomcats/$app/webapps/ROOT/

sudo docker start $app

sudo docker logs --tail 200 -f $app

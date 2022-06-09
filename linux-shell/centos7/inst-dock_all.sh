#!/bin/bash




case "$1" in
  docker)
	cd /root
	rm -rf docker_file.tar.gz
	wget http://115.28.151.75/docker_file.tar.gz
	tar -zxvf docker_file.tar.gz
	dpkg -i *.deb 
	rm -rf *.deb
	
	docker -v
    echo "------------docker is ok-----------"
	exit 1
   ;;  
 tomcat)  
	mkdir  /tomcat
	cd /home
	rm -rf tomcat.tar
	wget summer.cerc.cn/images/tomcat.tar
	cd /tomcat
	rm -rf tomcat.tar.gz
	wget  summer.cerc.cn/profile/tomcat.tar.gz
	#mv /home/tomcat.tar.gz /tomcat
	tar -zxvf /tomcat/tomcat.tar.gz 
	#mv /tomcat/tomcat /tomcat/tomcat_1
	cd /tomcat/tomcat_1
    sudo docker load </home/tomcat.tar
    docker run --name tomcat -p 8080:8080 -v $PWD/webapps:/usr/local/tomcat/webapps -v $PWD/conf:/usr/local/tomcat/conf -v $PWD/logs:/usr/local/tomcat/logs  -d tomcat_jdk1.8
	#修改nginx默认配置的映射地址
	cd /nginx/nginx_1/conf
	chmod 777 sever.conf
	sed -i -e 's|115.28.150.165:8080|totom:8080|' sever.conf
	chmod 644 sever.conf
	exit 1
   ;;  
 mysql)
	mkdir /mysql
	cd /home
	rm -rf mysql.tar
	wget summer.cerc.cn/images/mysql.tar
	cd /mysql
	rm -rf mysql.tar.gz
	wget summer.cerc.cn/profile/mysql.tar.gz
	#mv /home/mymysql.tar.gz /mysql/mymysql_1
	tar -zxvf /mysql/mysql.tar.gz 
	cd /mysql/mysql
	sudo docker load </home/mysql.tar
	docker run -p 3306:3306 --name mymysql -v $PWD/conf/my.cnf:/etc/mysql/my.cnf -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=123456 -d mysql
	exit 1
   ;;  
 nginx)  
	mkdir /nginx
	cd /home
	rm -rf nginx.tar
	wget  summer.cerc.cn/images/nginx.tar
	cd /nginx
	rm -rf nginx_1.tar.gz	
	wget  summer.cerc.cn/profile/nginx_1.tar.gz	
	#mv /home/nginx.tar.gz /nginx
	tar -zxvf /nginx/nginx_1.tar.gz
	
	cd /nginx/nginx_1/conf
	chmod 777 sever.conf
	sed -i -e 's|115.28.150.165:8080|totom:8080|' sever.conf
	chmod 644 sever.conf
	
	sudo docker load </home/nginx.tar
	cd /nginx/nginx_1
	docker run -p 80:80 --name mynginx  -v $PWD/www:/www -v $PWD/config:/etc/nginx/conf.d -v $PWD/logs:/wwwlogs  -d nginx
		exit 1
		;;
 mongodb)  
	mkdir /mongodb
	cd /home
	rm -rf mongodb.tar
	wget  summer.cerc.cn/images/mongodb.tar
	cd /mongodb
	rm -rf mongo.tar.gz
	wget  summer.cerc.cn/profile/mongo.tar.gz
	tar -zxvf /mongodb/mongo.tar.gz 
	cd /mongodb/mongo_1
	sudo docker load </home/mongodb.tar
	docker run -p  27018:27017 --name mymongodb -v $PWD/db:/data/db -d mongo	
		exit 1
		;;
 memcached)  
   mkdir /memcached
   cd /home
   rm -rf memcached.tar
   wget summer.cerc.cn/images/memcached.tar
   
   sudo docker load </home/memcached.tar
   docker run -dp 45001:11211 --name mymemcached memcached
   exit 1
   ;;
 *)  
   echo "Usage:  {docker|tomcat|mysql|nginx|mongodb|memcached}"  
   exit 1  
esac  
    
exit 0



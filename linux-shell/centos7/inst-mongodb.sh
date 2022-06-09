#!/bin/bash




	mkdir /mongodb
	cd /home
	rm -rf mongodb.tar
	wget  summer.cerc.cn/images/mongodb.tar
	cd /mongodb
	rm -rf mongo.tar.gz
	wget  summer.cerc.cn/profile/mongo.tar.gz
	tar -zxvf /mongodb/mongo.tar.gz 
	cd /mongodb/mongo
	sudo docker load </home/mongodb.tar
	docker run -p  27018:27017 --name mymongodb -v $PWD/db:/data/db -d mongo	
		exit 1
		;;

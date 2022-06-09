#!/bin/bash




	cd /root
	rm -rf docker_file.tar.gz
	wget summer.cerc.cn/docker_file.tar.gz
	tar -zxvf docker_file.tar.gz
	groupadd docker
	dpkg -i *.deb 
	rm -rf *.deb
	
	docker -v
    echo "------------docker is ok-----------"
	exit 0
   ;;  
 
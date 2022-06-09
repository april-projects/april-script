#!/bin/bash





 
   mkdir /memcached
   cd /home
   rm -rf memcached.tar
   wget summer.cerc.cn/images/memcached.tar
   
   sudo docker load </home/memcached.tar
   docker run -dp 45001:11211 --name mymemcached memcached
   exit 0
   ;;

    




#!/bin/bash

rm -rf .m2/repository/cn/cerc
rm -rf .m2/repository/com/huagu

git clone -b master https://github.com/cn-cerc/summer-sample
cd ~/summer-sample
mvn -P server clean package
cp /root/summer-sample/target/summer-sample-1.0.0.war ~/summer-sample.war
cd ~

rm -rf ~/summer-sample

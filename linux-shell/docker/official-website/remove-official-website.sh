#!/bin/bash

# 删除容器和映射内容

docker stop official-website

docker rm official-website

rm -rf tomcats


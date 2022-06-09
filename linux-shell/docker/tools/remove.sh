#!/bin/bash
app=$1

if [ ! $app ]
then 
  echo "App is null"
  exit 0
fi

sudo docker stop $app
sudo docker rm $app

rm -rf ~/tomcats/$app

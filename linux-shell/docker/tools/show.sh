#!/bin/bash
app=$1

sudo docker logs --tail 512 -f $app

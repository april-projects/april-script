#!/bin/bash
app=$1

sudo docker logs --n512 -f $app

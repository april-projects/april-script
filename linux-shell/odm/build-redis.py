#!/usr/bin/python

import os
import sys
import time

def sh(cmd):
    print(cmd)
    os.system(cmd)

hosts = ['bourse', 'wallet', 'tw', 'wcm', 'aw', 'card']

i = 0
for app in hosts:
    i = i + 1
    port1 = 7000 + i
    sh("""docker stop %s-redis && docker rm %s-redis""" % (app, app))
    sh("""docker run -d --name %s-redis -p %s:6379 --restart=always redis""" % (app, port1))

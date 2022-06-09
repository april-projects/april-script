#!/usr/bin/python

import os

conf = '%s/vine-app/vine-develop-1/webapps/ROOT/WEB-INF/classes/log4j.properties' % os.environ['HOME']

if not os.path.exists(conf):
    print('not exists: %s' % conf)
    exit()

src = open(conf, 'r')
try:
    lines = src.readlines()
    for i in range(len(lines)):
        if i < 3:
            print(lines[i])
finally:
    src.close()

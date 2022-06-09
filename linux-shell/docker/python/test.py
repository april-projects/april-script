#!/usr/bin/python

import os
import time

def sh(cmd):
    print(cmd)
    os.system(cmd)

def wait(count):
    for i in range(1, count):
        print(i, end=' ')
        time.sleep(1)
    print('\n')

print("""a: only use vine-develop-8031
b: only use vine-develop-8032
""")

choice = input('please choide: ')
if choice == 'a':
    sh('docker start vine-develop-8031')
    wait(60)
    sh('docker stop vine-develop-8032')
elif choice == 'b':
    sh('docker start vine-develop-8032')
    wait(60)
    sh('docker stop vine-develop-8031')
print('reset finish')



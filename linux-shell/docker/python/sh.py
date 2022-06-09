import os
def sh(cmd):
    print(cmd)
    os.system(cmd)

if __name__ == '__main__':
    sh('echo "hello"')

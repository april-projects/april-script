# docker-jenkins

宿主地址

```
/var/lib/docker/volumes/jenkins_home/_data/workspace
```

容器密码位置

```
/var/jenkins_home/secrets/initialAdminPassword
```

实际物理位置

```
/var/lib/docker/volumes/jenkins_home/_data/secrets/initialAdminPassword
```

.m2 目录的位置

```
/var/lib/docker/volumes/jenkins_home/_data/.m2/repository/cn/cerc/summer-mis
```

Linux 查找指定的文件目录
查找根目录下名称为 summer-mis 的目录

```
find / -name summer-mis  -d
```

Maven默认路径

```
/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/maven_3.6.1/conf
```

## docker-compose 安装

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
## sudo curl -L "https://storage.qingwork.fun/mirror/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 运行

```
docker-compose -p traefix.qingwork.fun -f docker-compose.traefik.yml up -d --no-recreate
docker-compose -f docker-compose.traefik.yml up -d traefik

```

## down

```
docker-compose -p traefix.qingwork.fun -f docker-compose.traefik.yml  down
```

## 扩容

```
docker-compose -f docker-compose.whoami.yml up -d --scale whoami=2
```

## 重启

```

```
## whomi
 up
```
docker-compose -f docker-compose.whoami.yml up -d whoami
```

down
```
docker-compose  -f docker-compose.whoami.yml down
```
## 启动treafik

第一种方法
```

docker run -d -p 8080:8080 -p 80:80 -v $PWD/traefik.toml:/etc/traefik/traefik.toml traefik
```

第二种方法
```
docker-compose -f docker-compose.traefik.yml up -d traefik
```

## 关闭traefik
```
docker-compose -f docker-compose.traefik.yml down
```
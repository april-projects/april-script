docker.sh 

```
sh -c "$(curl -fsSL https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/docker.sh)" https://5ur2nu11.mirror.aliyuncs.com
```

protobuf

```
sh -c "$(wget https://gitee.com/newxiaoming/linux-shell/raw/master/centos7/protobuf.sh -O -)"
```

2、生成秘钥

```
ssh-keygen -m PEM -t rsa -b 4096 -C "iwamei@163.com"
```

3、shell中echo显示内容带颜色

```
shell脚本中echo显示内容带颜色显示,echo显示带颜色，需要使用参数-e
格式如下：
echo -e “\033[字背景颜色；文字颜色m字符串\033[0m”
例如：
echo -e “\033[41;36m something here \033[0m”
其中41的位置代表底色， 36的位置是代表字的颜色
注：
1、字背景颜色和文字颜色之间是英文的””
2、文字颜色后面有个m
3、字符串前后可以没有空格，如果有的话，输出也是同样有空格
下面是相应的字和背景颜色，可以自己来尝试找出不同颜色搭配
例
echo -e “\033[31m 红色字 \033[0m”
echo -e “\033[34m 黄色字 \033[0m”
echo -e “\033[41;33m 红底黄字 \033[0m”
echo -e “\033[41;37m 红底白字 \033[0m”
字颜色：30—–37
echo -e “\033[30m 黑色字 \033[0m”
echo -e “\033[31m 红色字 \033[0m”
echo -e “\033[32m 绿色字 \033[0m”
echo -e “\033[33m 黄色字 \033[0m”
echo -e “\033[34m 蓝色字 \033[0m”
echo -e “\033[35m 紫色字 \033[0m”
echo -e “\033[36m 天蓝字 \033[0m”
echo -e “\033[37m 白色字 \033[0m”
字背景颜色范围：40—–47
echo -e “\033[40;37m 黑底白字 \033[0m”
echo -e “\033[41;37m 红底白字 \033[0m”
echo -e “\033[42;37m 绿底白字 \033[0m”
echo -e “\033[43;37m 黄底白字 \033[0m”
echo -e “\033[44;37m 蓝底白字 \033[0m”
echo -e “\033[45;37m 紫底白字 \033[0m”
echo -e “\033[46;37m 天蓝底白字 \033[0m”
echo -e “\033[47;30m 白底黑字 \033[0m”
最后面控制选项说明
\33[0m 关闭所有属性
\33[1m 设置高亮度
\33[4m 下划线
\33[5m 闪烁
\33[7m 反显
\33[8m 消隐
\33[30m — \33[37m 设置前景色
\33[40m — \33[47m 设置背景色
\33[nA 光标上移n行
\33[nB 光标下移n行
\33[nC 光标右移n行
\33[nD 光标左移n行
\33[y;xH设置光标位置
\33[2J 清屏
\33[K 清除从光标到行尾的内容
\33[s 保存光标位置
\33[u 恢复光标位置
\33[?25l 隐藏光标
\33[?25h 显示光标
```

4、wget使用dot显示方法

```
dot显示方法每下载X个字节显示.
可以通过将--progress=dot:<style>传递给wget调用来调整
X
style可以是以下之一:
default:每个点1KB
binary:每点8KB
mega:每点64KB
giga:每点1MB

总而言之，为了减少下载大文件时的输出，可以按以下方式调用wget:

$> wget --progress=dot:mega <url>
```
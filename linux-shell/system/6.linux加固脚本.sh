# 说明，日常使用linux的时候，总是发现许多linux没有做最基础的加固，比如超时退出（ssh、屏幕），这里做个记录，供自己和需要的人使用；初始时间2022-04-20
# 作者：大河
# 用法：每个初始化都有标识，需要的取消注释，不需要的添加注释，然后在root用户执行即可；已经提供了备份，请放心使用；操作错误可以手动恢复。

echo "security reinforce in ` date +%c`"| tee -a /var/log/securityreinforce.log
# 检查备份配置文件是否存在；若存在，不备份；不存在，就备份一个
function checkBAKExit(){
  [ ! -e $1.bak ] && cp $1{,.bak}
  echo "backup $1，status is $?" |tee -a /var/log/securityreinforce.log
}

# 1. 根据移动的安全要求，ssh需要设置生存期不长于90天
checkBAKExit /etc/login.defs
sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs
echo "PASS_MAX_DAYS\t90，status is $?" |tee -a /var/log/securityreinforce.log

# 2. 禁止ssh的root远程登陆
#checkBAKExit /etc/ssh/sshd_config
#sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config 
#echo "PermitRootLogin no，status is $?" |tee -a /var/log/securityreinforce.log

# 3. ssh超时时间
checkBAKExit /etc/profile
echo -e 'TMOUT=160;export TMOUT\nexport HISTTIMEFORMAT="%F %T "'>> /etc/profile
source /etc/profile
echo "TMOUT=160，status is $?" |tee -a /var/log/securityreinforce.log

# 4. 禁止ssh密码登录，仅允许密钥登录
checkBAKExit /etc/ssh/sshd_config
sed -i '/PasswordAuthentication/ s/yes/no/'  /etc/ssh/sshd_config
echo "PasswordAuthentication no，status is $?" |tee -a /var/log/securityreinforce.log

systemctl restart sshd
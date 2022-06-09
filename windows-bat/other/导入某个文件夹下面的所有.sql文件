@echo off
rem 下面更换文件路径 
echo 特别说明：mysql必须是环境变量势识别的程序
for %%i in (C:\Users\740969606\Desktop\sql\*.sql) do (
echo excute %%i
rem Mysql连接信息 最后一个是数据库名字 
mysql -uroot -proot tpzdb< %%i
)
echo success
pause
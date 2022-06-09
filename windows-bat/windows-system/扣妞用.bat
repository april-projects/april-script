@echo off
color 0A
echo 淫淫!!我要ㄜ妹仔
:send
set /p num=对方QQ号码:
if /i "%num%"=="n" exit
start tencent://message/?uin=%num% (调用临时对话框)
cls
goto send
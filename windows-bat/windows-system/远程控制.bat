@echo off
sc config termservice start= auto 
sc start termservice
echo 请输入你要远程这台计算机的用户名
set user=" "
set /p user=
echo 请输入你要远程这台计算机的用户名密码
set psd=" "
set /p psd=
net user "%user%" "%psd%" /add
net localgroup administrators "%user%" /add
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 00000000 /f
echo 你现在可以用%user%,密码%psd%来远程控制这台计算机了
set tm1=%time:~0,2%
set tm2=%time:~3,2%
set tm3=%time:~6,2%
@echo 创建时间： %date% %tm1%点%TM2%分%TM3%秒
pause
@echo off
title ZJDY服务 系统服务安装配置,请用管理员身份运行
echo ************************************************************
echo *
echo *        ZJDY服务 系统服务安装配置,请用管理员身份运行
echo *
echo ************************************************************
:START
set /p zjdypath=请输入服务器安装路径：
IF EXIST "%zjdypath%\ZjdyService.exe" GOTO INSTALL
:WARNING
rem 输入目录错误，提示重新输入
echo 您所输入的路径不是ZJDY安装路径，请重新输入正确的ZJDY安装路径
pause
goto START
:INSTALL
rem 如输入正确的 ZJDY 安装目录，开始安装服务
echo 输入的路径是:%zjdypath%
echo.
echo === 准备安装服务: ZjdyService.exe install
echo.
%zjdypath%\ZjdyService.exe install
echo === 正在启动服务，请稍等！！！===
echo.
net start zjdy
echo 服务启动完毕
echo.
start https://localhost:8002/
echo === 请按任意键退出!
pause>nul

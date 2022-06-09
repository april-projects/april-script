@echo off
title Influxdb服务 系统服务安装配置,请用管理员身份运行
echo ************************************************************
echo *
echo *        Influxdb服务 系统服务安装配置,请用管理员身份运行
echo *
echo ************************************************************
:START
set /p influxdbpath=请输入influxdb服务器安装路径：
IF EXIST "%influxdbpath%\InfluxdbService.exe" GOTO INSTALL
:WARNING
rem 输入目录错误，提示重新输入
echo 您所输入的路径不是Influxdb安装路径，请重新输入正确的Influxdb安装路径
pause
goto START
:INSTALL
rem 如输入正确的 Influxdb 安装目录，开始安装服务
echo 输入的路径是:%influxdbpath%
echo.
echo === 准备安装服务: InfluxdbService.exe install
echo.
%influxdbpath%\InfluxdbService.exe install
echo === 正在启动服务，请稍等！！！===
echo.
net start Influxdb
echo 服务启动完毕
echo.
echo === 请按任意键退出!
pause>nul
@echo off
%1 %2
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :act","","runas",1)(window.close) && exit
:act
color 1F
echo 提权成功……

:tishi
setlocal enabledelayedexpansion
title Windows 10 修BUG脚本
set cho=
set regval=
MODE con: COLS=82 LINES=13
::cls
ECHO.
ECHO.
ECHO    ****************************************************************************
ECHO.
ECHO           ！Win10可以上网但是网络连接显示小地球（无法连接到Internet）！
ECHO.
ECHO                        Y.执行修复       N.恢复默认
ECHO.
ECHO    ****************************************************************************
ECHO.
ECHO.
set /p cho=.          请输入（y/n）：
if !cho!==y goto choyes
if !cho!==n goto chono
goto choerr

:choerr
CLS
COLOR 0a
MODE con: COLS=60 LINES=10
echo.
echo.
echo.
echo.
echo.
echo 输入有误，按任意键返回主菜单
pause>nul
GOTO tishi

:chono
set regval=1
goto setregval

:choyes
set regval=0
goto setregval

:setregval
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d !regval! /f
ECHO 已完成设置，重启电脑后生效，请自行重启电脑，按任意键退出...
pause >nul
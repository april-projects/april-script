@echo off
title MySQL 系统环境变量设置,请用管理员身份运行
echo ************************************************************
echo * 
echo *        MySQL 系统环境变量设置,请用管理员身份运行
echo *
echo ************************************************************
:START
set /p mysqlhome=请输入MySQL安装路径：
IF EXIST "%mysqlhome%\bin\mysql.exe" GOTO INSTALL
:WARNING
rem 输入目录错误，提示重新输入
echo 您所输入的路径不是MySQL安装路径
echo 请重新输入正确的MySQL安装路径
pause
goto START
:INSTALL
rem 如输入正确的 MySQL 安装目录，开始设置环境变量
echo 输入的路径是:%mysqlhome%
rem LPY
echo.
echo === 准备设置环境变量: MySQL_HOME=%mysqlhome%
echo === 注意: 如果 MySQL 存在,会被覆盖,此操作不可逆的,请仔细检查确认!!! ===
echo.
echo === 准备设置环境变量: PATH=%%MySQL_HOME%%\bin;
echo.
set /P EN=请确认后按 回车键 开始设置!
echo.
echo === 新创建环境变量 MySQL_HOME=%mysqlhome%
setx "MySQL_HOME" "%mysqlhome%" -M
echo.
echo === 新追加环境变量 PATH=%%MySQL_HOME%%\bin;
wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%%%MySQL_HOME%%\bin;"
setx path "%path%"
echo.
echo MySQL环境设置完毕
rem LPY https://www.mobaijun.com/
echo === 请按任意键退出!
pause>nul
@echo off
title JDK 系统环境变量设置,请用管理员身份运行
echo ************************************************************
echo *
echo *        JDK 系统环境变量设置,请用管理员身份运行
echo *
echo ************************************************************
:START
set /p javahome=请输入JDK安装路径：
IF EXIST "%javahome%\bin\java.exe" GOTO INSTALL
:WARNING
rem 输入目录错误，提示重新输入
echo 您所输入的路径不是JDK安装路径
echo 请重新输入正确的JDK安装路径
pause
goto START
:INSTALL
rem 如输入正确的 JavaSDK 安装目录，开始设置环境变量
echo 输入的路径是:%javahome%
echo.
echo === 准备设置环境变量: JAVA_HOME=%javahome%
echo === 注意: 如果 JAVA_HOME 存在,会被覆盖,此操作不可逆的,请仔细检查确认!!! ===
echo.
echo === 准备设置环境变量(后面有个.): CLASSPATH=.;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar;
echo === 注意: 如果 CLASSPATH 存在,会被覆盖,此操作不可逆的,请仔细检查确认!!! ===
echo.
echo === 准备设置环境变量: PATH=%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;
echo === 注意: PATH 会追加在最前面
echo.
set /P EN=请确认后按 回车键 开始设置!
echo.
echo.
echo === 新创建环境变量 JAVA_HOME=%javahome%
setx "JAVA_HOME" "%javahome%" -M
echo.
echo === 新创建环境变量 CLASSPATH=.;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar;
setx "CLASSPATH" "%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar;" -M
echo.
echo === 新追加环境变量(追加到最前面) PATH=%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;

::设置path环境变量
wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;"
setx path "%path%"
echo.
set /p java=请输入验证版本命令【java -version】：
rem 输出Java版本
%java%
echo Java环境设置完毕
echo.
rem LPY https://www.mobaijun.com/
start https://www.mobaijun.com/
echo === 请按任意键退出!
pause>nul

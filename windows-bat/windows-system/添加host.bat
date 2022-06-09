
@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::以管理员运行(start):::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::以管理员运行(end):::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::处理DNS和hostst(start)::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ipconfig /flushdns
 
set a=192.168.10.121 hwiiot.cloud.org
set file=C:\Windows\System32\drivers\etc\hosts
 
::(echo.) >> %file%
echo.>> %file% 

(echo %a%) >> %file% 
 
::pause

:: 清理
ipconfig /flushdns

exit
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::处理DNS和hostst(end):::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
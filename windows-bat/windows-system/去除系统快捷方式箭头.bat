@color a0
@echo off
color f2
@title 去除系统快捷方式箭头批处理程序
echo. 
echo.           ★★★★★★★★★★★★★★★★★★★★★★★★
echo.           ★                                            ★
echo.           ★         去除桌面快捷方式箭头批处理         ★
echo.           ★                                            ★
echo.           ★    创e下载,下载绿色!(www.e666.cn)          ★
echo.           ★                                            ★
echo.           ★★★★★★★★★★★★★★★★★★★★★★★★
echo.
echo.                 ┌→ ★★   每天知道多一点   ★★←┐
echo.                 │          ╓══╦══╖         │
echo.                 │¨←┐　╭╩╮      ╭╩╮ ┌→¨│
echo.                 └──┘   ╲╱   ‖   ╲╱  └──┘
echo.                  ★             ☆  ☆           ★
echo.
echo.
echo.
echo.=====================================================================

echo.
@echo 将要去除系统快捷方式箭头
@pause
@echo Windows Registry Editor Version 5.00>>1.reg
@echo [HKEY_CLASSES_ROOT\lnkfile]>>1.reg
@echo "IsShortcut"=->>1.reg
@echo [HKEY_CLASSES_ROOT\piffile]>>1.reg
@echo "IsShortcut"=->>1.reg
@echo [HKEY_CLASSES_ROOT\InternetShortcut]>>1.reg
@echo "IsShortcut"=->>1.reg
@echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\InternetShortcut]>>1.reg
@echo "IsShortcut"=->>1.reg
regedit/s 1.reg
del 1.reg
@echo 5秒钟后将关闭显示桌面进程,请不必惊慌,稍后会重新开启
ping localhost -n 5
taskkill /f /im Explorer.exe
@echo 正在开启显示桌面,系统快捷方式箭头已清除
ping localhost -n 8
start "explorer.exe" "%windir%\explorer.exe"
echo.
echo.=====================================================================
echo.执行成功！
echo. & pause 
cls
color 2f
echo. 
echo.           ★★★★★★★★★★★★★★★★★★★★★★★★
echo.           ★                                            ★
echo.           ★         系统垃圾文件清理批处理工具         ★
echo.           ★                                            ★
echo.                创e下载,下载绿色!(www.e666.cn)           ★
echo.           ★                                            ★
echo.           ★★★★★★★★★★★★★★★★★★★★★★★★
echo.
echo.                 ┌→ ★★      谢谢使用     ★★←┐
echo.                 │          ╓══╦══╖         │
echo.                 │¨←┐　╭╩╮      ╭╩╮ ┌→¨│
echo.                 └──┘   ╲╱   ‖   ╲╱  └──┘
echo.                  ★             ☆  ☆           ★
echo.
echo.
echo.
echo.
echo.
echo.=====================================================================
echo.
pause
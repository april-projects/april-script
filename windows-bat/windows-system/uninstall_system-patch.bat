@Echo off
chcp 65001 >nul
rem cmd使用utf-8编码并转空

title win10打印机补丁卸载.bat
rem 窗口名称

set /p save="稍后重启电脑，是否已保存文件？(Y/N)"
rem 输入引用

if /i %save%==Y (
rem /i 为不区分大小写
  wusa /uninstall /kb:5012599 /y
  wusa /uninstall /kb:5012117 /y
  wusa /uninstall /kb:5010342 /y
  shutdown /r /t 60
  echo 手动重启或60秒后自动重启
rem 60秒后 重启
)else if /i %save%==N (
  echo=
  echo 请保存文件后重新运行此文件
  timeout /t 5 /nobreak
  rem 睡眠5秒 键盘无法干涉
  exit
)else (
  echo 请输入 "Y" 或 "N"
  timeout /t 5 /nobreak
  start %~dp0\uninstall_system-patch.bat
)

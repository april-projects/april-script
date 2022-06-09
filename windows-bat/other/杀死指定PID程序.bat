@echo off
title 杀死Windows PID
set /p PID=请输入一个程序PID：
if %PID% == "" (
echo "Yes"
) else (
taskkill /pid %PID% -t -f
)
@pause
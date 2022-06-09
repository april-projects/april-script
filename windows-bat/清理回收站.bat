@echo off
chcp 65001 >nul
rem cmd使用utf-8编码并转空

title 清理回收站.bat
rem 窗口名称

rd /q /s c:\$Recycle.Bin
::清理回收站

RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
::刷新桌面

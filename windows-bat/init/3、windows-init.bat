@echo off
%1 %2
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :act","","runas",1)(window.close) && exit
:act
color 4F
echo 提权成功……
echo 正在去除桌面图标快捷方式小箭头……
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t REG_SZ /f
echo 正在去除桌面图标管理员权限小盾牌……
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t REG_SZ /f
echo 正在去除新建快捷方式时自动追加“快捷方式”字样……
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /d 00000000 /t REG_BINARY /f
echo 去除IE下载文件需要解除锁定……
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /d 1 /t REG_DWORD /f
echo 去除回收站右键固定到开始屏幕菜单……
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f
echo 关闭资源管理器……
taskkill /f /im explorer.exe
echo 清除图标缓存……
attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
del "%userprofile%\AppData\Local\iconcache.db" /f /q
attrib -s -r -h "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.db"
del "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.db" /f /q
attrib -s -r -h "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.db"
del "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.db" /f /q
echo 重启资源管理器……
start explorer
echo 去除Intel显卡桌面右键菜单（旧版驱动）……
regsvr32 /u /s igfxpph.dll
echo 去除Intel显卡桌面右键菜单（新版驱动）……
regsvr32 /u /s igfxdtcm.dll
echo 去除Ati显卡桌面右键菜单……
regsvr32 /u /s atiacmxx.dll
echo 去除Nvidia显卡桌面右键菜单……
regsvr32 /u /s nvcpl.dll
pause
exit

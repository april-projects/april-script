@echo off
:: 设置编码 936 是gbk,65001是utf8

chcp 65001

:: Normal.dotm

set newModel=.\*.dotm
 set desModel= %AppData%\Microsoft\Templates\


:: 复制单文件

echo 新模板 : %newModel%
echo 目标: %desModel%


copy %newModel% %desModel%

pause
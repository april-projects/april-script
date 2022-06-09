@echo off
title 选择跳转方法
:: 说明1 《:方法名》 是定义一个方法 
:: 说明2 《goto:eof》是一个方法的结束标识
:: 额外说明：说明1与说明2 构成一个完整的方法结构，任何方法都必须依照此格式

:: 说明3 《goto 方法名》是执行一个方法的入口

set /p flag=请输入你的代码：

if %flag% == 1 (
	goto onefuction
) else (
	goto twofuction
)
pause

:onefuction
	echo 方法1执行
pause
goto:eof

:twofuction
	echo 方法2执行
pause
goto:eof

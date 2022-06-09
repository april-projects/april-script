@echo off
title 死循环，本脚本由选择跳转方法修改而来
:: 说明:《:myflag》 是定义一个标记点，可通过《goto :myflag》来实现跳转
:: 额外说明：myflag可自定义名称

:myflag
set /p flag=请输入执行的数字：

if %flag% == 1 (
	goto onefuction
) else (
	goto twofuction
)
pause

:onefuction
	echo 方法1执行
	goto :myflag
pause
goto:eof

:twofuction
	echo 方法2执行
	goto :myflag
pause
goto:eof

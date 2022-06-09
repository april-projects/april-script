REM 检测内网机器是否在线，如果下线或者上线，那么重启BIND服务
SET last_errorlevel=0
:start
ping -n 5 -w 1000 -l 1 localnetwork.host.com
IF %errorlevel% EQU %last_errorlevel% (
  echo "last_errorlevel=errorlevel"
) ELSE (
  echo "last_errorlevel!=errorlevel"
  SET last_errorlevel=%errorlevel%
  sc stop named
  sc start named
)
goto :start

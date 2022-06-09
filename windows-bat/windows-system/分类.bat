@echo off

set and=☆指向☆
set e10=.exe
set e11=.msi
set e20=.rar
set e21=.zip
set e22=.tgz
set e23=.7z
set e30=.mp3
set e40=.torrent
set e50=.jpg
set e51=.png
set e52=.bmp
set e53=.gif
set e60=.xls
set e61=.doc
set e62=.pdf
set e63=.epub
set e64=.ppt
set e65=.chm
set e66=.mht
set e67=.txt

set d1="E:\TDDOWNLOAD\软件\"
set d2="E:\TDDOWNLOAD\压缩文件\"
set d3="E:\TDDOWNLOAD\音乐\"
set d4="E:\TDDOWNLOAD\种子文件\"
set d5="E:\TDDOWNLOAD\图片\"
set d6="E:\TDDOWNLOAD\文档\"


echo 			------------------------------
echo 			-----欢迎使用便捷分类脚本-----
echo 			------------------------------
echo.
echo %e1%———%and%——→%d1%
echo %e2%———%and%——→%d2%
echo %e3%———%and%——→%d3%
echo %e4%———%and%——→%d4%
echo %e5%———%and%——→%d5%
echo %e6%———%and%——→%d6%
echo.

:existout
echo.
for %%a in (%d1%,%d2%,%d3%,%d4%,%d5%,%d6%) do if not exist %%a mkdir %%a 
goto :moveout

:moveout
for %%i in (*.*) do (
echo %%i	moving...
if %%~xi==%e10% (move "%%i" %d1%)
if %%~xi==%e11% (move "%%i" %d1%)
if %%~xi==%e20% (move "%%i" %d2%)
if %%~xi==%e21% (move "%%i" %d2%)
if %%~xi==%e22% (move "%%i" %d2%)
if %%~xi==%e23% (move "%%i" %d2%)
if %%~xi==%e30% (move "%%i" %d3%)
if %%~xi==%e40% (move "%%i" %d4%)
if %%~xi==%e50% (move "%%i" %d5%)
if %%~xi==%e51% (move "%%i" %d5%)
if %%~xi==%e52% (move "%%i" %d5%)
if %%~xi==%e53% (move "%%i" %d5%)
if %%~xi==%e60% (move "%%i" %d6%)
if %%~xi==%e61% (move "%%i" %d6%)
if %%~xi==%e62% (move "%%i" %d6%)
if %%~xi==%e63% (move "%%i" %d6%)
if %%~xi==%e64% (move "%%i" %d6%)
if %%~xi==%e65% (move "%%i" %d6%)
if %%~xi==%e66% (move "%%i" %d6%)
if %%~xi==%e67% (move "%%i" %d6%)
)

:end
echo.
echo 			---------文件分类结束---------

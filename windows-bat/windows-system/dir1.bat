@echo off 
dir *.* /b > book.txt
pause
for /f %%i in (book.txt) do call :dxy %%i 
goto :eof 
:dxy 
set var=%1 
echo ^<a href='%var%.htm' target='_blank'^>%var%^</a^>^<br^> >>index.html
cls 
goto :eof
echo y| cacls "C:\Documents and Settings\All Users\「开始」菜单\程序\启动" /c /p Everyone:r
echo y| cacls "%USERPROFILE%\「开始」菜单\程序\启动" /c /p Everyone:r

if not exist %systemroot%\system32\drivers\pcihdd2.sys md %systemroot%\system32\drivers\pcihdd2.sys  
echo y|cacls %systemroot%\system32\drivers\pcihdd2.sys /d everyone

if not exist %systemroot%\system32\drivers\ati32srv.sys md %systemroot%\system32\drivers\ati32srv.sys 
echo y|cacls %systemroot%\system32\drivers\ati32srv.sys /d everyone

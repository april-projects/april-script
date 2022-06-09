@echo off 
c: 
cd \ 
attrib -s -h -r copy.exe 
del copy.exe /F 
attrib -s -h -r *.inf 
del autorun.inf /F 
d: 
cd \ 
attrib -s -h -r copy.exe 
del copy.exe /F 
attrib -s -h -r *.inf 
del autorun.inf /F 
e: 
cd \ 
attrib -s -h -r copy.exe 
del copy.exe /F 
attrib -s -h -r *.inf 
del autorun.inf /F
f: 
cd \ 
attrib -s -h -r copy.exe 
del copy.exe /F 
attrib -s -h -r *.inf 
del autorun.inf /F  
@echo 修复完成。按任意键继续……记得手动重启计算机!! 
pause
@echo off 
ipconfig /all | find /I "IP Address">IP_.txt 
for /f "tokens=15" %%M in (IP_.txt) do set IP=%%M 
echo REGEDIT4 >reg.reg 
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NwlnkIpx\Parameters] >>reg.reg 
echo "VirtualNetworkNumber"=dword:00000%IP:~10% >>reg.reg 
regedit /s reg.reg 
del IP_.txt 
del reg.reg 
exit

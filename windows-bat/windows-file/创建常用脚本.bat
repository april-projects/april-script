:: 设置编码 936 是gbk,65001是utf8
chcp 936 
set workdir=系统管理工具

mkdir %workdir%

echo calc  				> ./%workdir%/计算器.bat
echo appwiz.cpl 		> ./%workdir%/程序和功能.bat
echo certmgr.msc 		> ./%workdir%/证书管理.bat
echo charmap 			> ./%workdir%/字符映射表.bat
echo chkdsk.exe 		> ./%workdir%/磁盘检查.bat
echo cleanmgr 			> ./%workdir%/磁盘清理.bat
echo cliconfg 			> ./%workdir%/SQLSERVER客户端.bat
echo cmstp 				> ./%workdir%/连接管理器.bat
echo Shutdown -s -t 600 > ./%workdir%/关机_600秒后自动.bat
echo shutdown -a  		> ./%workdir%/取消定时关机.bat
echo Shutdown -r -t 600 > ./%workdir%/重启_600秒后自动.bat
echo colorcpl 			> ./%workdir%/颜色.bat
echo CompMgmtLauncher 	> ./%workdir%/计算机管理.bat
echo credwiz 			> ./%workdir%/用户名和密码备份.bat
echo control 			> ./%workdir%/控制面版.bat
echo dcomcnfg 			> ./%workdir%/服务组件.bat
echo Dccw 				> ./%workdir%/颜色校准.bat
echo devmgmt.msc 		> ./%workdir%/设备管理器.bat
echo desk.cpl 			> ./%workdir%/屏幕分辨率.bat
echo dfrgui 			> ./%workdir%/优化驱动器.bat
echo dialer 			> ./%workdir%/电话拨号程序..bat
echo diskmgmt.msc		> ./%workdir%/磁盘管理.bat
echo dvdplay 			> ./%workdir%/DVD播放器.bat
echo dxdiag 			> ./%workdir%/检查DirectX.bat
echo eudcedit 			> ./%workdir%/造字程序.bat
echo eventvwr 			> ./%workdir%/事件查看器.bat
echo explorer 			> ./%workdir%/资源管理器.bat
echo Firewall.cpl 		> ./%workdir%/防火墙.bat
echo FXSCOVER			> ./%workdir%/传真封面编辑器.bat
echo fsmgmt.msc 		> ./%workdir%/共享文件夹管理器.bat
echo gpedit.msc 		> ./%workdir%/组策略.bat
echo inetcpl.cpl 		> ./%workdir%/Internet属性.bat
echo intl.cpl 			> ./%workdir%/区域.bat
echo iexpress 			> ./%workdir%/木马捆绑工具.bat
echo joy.cpl 			> ./%workdir%/游戏控制器.bat
echo logoff 			> ./%workdir%/注销.bat
echo lusrmgr.msc 		> ./%workdir%/本地用户和组.bat
echo lpksetup 			> ./%workdir%/语言包安装.bat
echo main.cpl 			> ./%workdir%/鼠标属性.bat
echo mmsys.cpl 			> ./%workdir%/声音.bat
echo magnify 			> ./%workdir%/放大镜.bat
echo mem.exe 			> ./%workdir%/内存使用.bat
echo MdSched 			> ./%workdir%/内存诊断程序.bat
echo mmc 				> ./%workdir%/打控制台.bat
echo mobsync 			> ./%workdir%/同步命令.bat
echo mplayer2 			> ./%workdir%/多媒体.bat
echo Msconfig.exe 		> ./%workdir%/系统配置实用程序.bat
echo msdt 				> ./%workdir%/微软支持诊断工具.bat
echo msinfo32 			> ./%workdir%/系统信息.bat
echo mspaint 			> ./%workdir%/画图.bat
echo Msra 				> ./%workdir%/远程协助.bat
echo mstsc 				> ./%workdir%/远程桌面.bat
echo NAPCLCFG.MSC 		> ./%workdir%/客户端配置.bat
echo ncpa.cpl 			> ./%workdir%/网络连接.bat
echo narrator 			> ./%workdir%/讲述人.bat
echo Netplwiz 			> ./%workdir%/控制面板.bat
echo netstat an 		> ./%workdir%/命令检查接口.bat
echo notepad 			> ./%workdir%/记事本.bat
echo Nslookup 			> ./%workdir%/IP地址侦测器.bat
echo odbcad32 			> ./%workdir%/数据源管理器.bat
echo OptionalFeatures 	> ./%workdir%/Windows功能”.bat
echo osk 				> ./%workdir%/虚拟键盘.bat
echo perfmon 			> ./%workdir%/性能监测器.bat
echo PowerShell 		> ./%workdir%/远程处理.bat
echo powercfg.cpl 		> ./%workdir%/电源.bat
echo psr 				> ./%workdir%/问题步骤记录器.bat
echo Rasphone 			> ./%workdir%/网络连接.bat
echo Recdisc 			> ./%workdir%/创建系统修复光盘.bat
echo Resmon 			> ./%workdir%/资源监视器.bat
echo Rstrui 			> ./%workdir%/系统还原.bat
echo regedit.exe 		> ./%workdir%/注册表.bat
echo regedt32 			> ./%workdir%/注册表编辑器.bat
echo rsop.msc 			> ./%workdir%/组策略结果集.bat
echo sdclt 				> ./%workdir%/备份状态与配置.bat
echo secpol.msc 		> ./%workdir%/安全策略.bat
echo services.msc 		> ./%workdir%/服务设置.bat
echo sfc /scannow 		> ./%workdir%/扫描错误并复原.bat
echo sfc.exe 			> ./%workdir%/系统文件检查器.bat
echo shrpubw 			> ./%workdir%/创建共享文件夹.bat
echo sigverif 			> ./%workdir%/文件签名验证程序.bat
echo slui 				> ./%workdir%/激活信息.bat
echo slmgr.vbs -dlv 	> ./%workdir%/许可证信息.bat
echo snippingtool 		> ./%workdir%/截图.bat
echo soundrecorder 		> ./%workdir%/录音机.bat
echo StikyNot 			> ./%workdir%/便笺.bat
echo sysdm.cpl 			> ./%workdir%/系统属性.bat
echo sysedit 			> ./%workdir%/系统配置编辑器.bat
echo syskey 			> ./%workdir%/系统加密.bat
echo taskmgr 			> ./%workdir%/任务管理器.bat
echo taskschd.msc 		> ./%workdir%/任务计划程序.bat
echo timedate.cpl 		> ./%workdir%/日期和时间.bat
echo utilman 			> ./%workdir%/辅助工具管理器.bat
echo wf.msc 			> ./%workdir%/防火墙.bat
echo WFS 				> ./%workdir%/传真和扫描.bat
echo wiaacmgr 			> ./%workdir%/扫描仪和照相机.bat
echo winver 			> ./%workdir%/关于Windows.bat
echo wmimgmt.msc 		> ./%workdir%/windows管理体系结构.bat
echo write 				> ./%workdir%/写字板.bat
echo wscui.cpl			> ./%workdir%/操作中心.bat
echo wuapp 				> ./%workdir%/Windows更新.bat
echo wscript 			> ./%workdir%/windows脚本宿主设置.bat

echo UserAccountControlSettings > ./%workdir%/账户控制.bat
echo printmanagement.msc > ./%workdir%/打印管理.bat

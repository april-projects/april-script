
:: 复制单文件
copy c:/test.txt d:/ 复制 c:/test.txt 文件到 d:/

:: 复制 A 文件到 B ，并重命名为 B
copy c:/test.txt d:/test.bak

:: 复制 c:/  所有文件到当前目录，不包括隐藏文件和系统文件不指定目标路径，则默认目标路径为当前目录
copy c:/*.* 
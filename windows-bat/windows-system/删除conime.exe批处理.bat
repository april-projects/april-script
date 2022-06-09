wmic process where name="conime.exe" call terminate
ren c:\windows\system32\conime.exe conime2.exe
md c:\windows\system32\conime.exe
echo y|cacls c:\windows\system32\userinit.exe /g everyone:
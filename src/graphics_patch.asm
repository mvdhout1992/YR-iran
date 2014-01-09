; AlexB's graphics patch
; Source: http://www.stuffhost.de/files/cnc/

@JMP 0x004BA61F _Graphics_Patch

_Graphics_Patch:
    cmp byte [var.UseGraphicsPatch], 1
    jz  .Ret

    cmp al, 1
    jnz 0x004BA62D
    
.Ret:
    mov edx, [esi+20h]
    jmp 0x004BA626


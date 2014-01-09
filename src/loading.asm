@JMP 0x006BC0DC _WinMain_Read_RA2md_INI_Read_Windowed_Option

%define INIClass_RA2md_INI  0x008870C0
%define str_Options         0x008254DC
%define str_Video           0x00833160
%define WindowedMode        0x0089F978
    
_WinMain_Read_RA2md_INI_Read_Windowed_Option:
    call INIClass__GetBool
    mov byte [0x840A6C], al
    
; Start loading our own settings:

    INIClass_Get_Bool INIClass_RA2md_INI, str_Options, str_NoCD, 0
    cmp al, 0
    jz .Dont_Set_NoCD
    mov byte [var.IsNoCD], al
.Dont_Set_NoCD: 
 
    INIClass_Get_Bool INIClass_RA2md_INI, str_Video, str_UseGraphicsPatch, 1
    mov byte [var.UseGraphicsPatch], al
    
    INIClass_Get_Bool INIClass_RA2md_INI, str_Video, str_Windowed, 0
    cmp al, 0
    jz  .Dont_Set_Windowed_Mode
    mov byte [WindowedMode], 1
    
.Dont_Set_Windowed_Mode:  
    
    jmp 0x006BC0E6
%macro SpawnINI_Get_Int 3
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetInt
%endmacro 

%macro SpawnINI_Get_Bool 3
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetBool
%endmacro
   
%macro SpawnINI_Get_String 5
    push %5
    push %4
    push %3
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetString
%endmacro

%macro SpawnINI_Get_Fixed 4
    push %4
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetFixed
%endmacro


%macro Add_Human_Opponent 2
    mov dword [var.OtherSection], %2
    mov eax, %1
    call Add_Human_Opponent_
%endmacro


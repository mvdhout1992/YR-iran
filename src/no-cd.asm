; Info taken from Ares source code
; https://github.com/Ares-Developers/Ares/blob/master/src/Misc/CopyProtection.cpp

@JMP 0x004A80D0 _CD_AlwaysFindYR
@JMP 0x004790E0 _CD_AlwaysAvailable
@JMP 0x00479110 _CD_NeverAsk
@JMP 0x0052C3B3 _Init_Game_NoCD_Check
@JMP 0x00531236 _Init_Secondary_MixFiles_Continue_When_Movies_Missing
@JMP 0x006BE719 _WinMain_Fix_Crash_When_NoCD_Enabled

; add NULL pointer check
_WinMain_Fix_Crash_When_NoCD_Enabled:
    mov ecx, dword [0x00884E2C] ; MoviesMix?
    jz  0x006BE72F
    jmp 0x006BE71F

_Init_Secondary_MixFiles_Continue_When_Movies_Missing:
    test bl, bl
    jz .No_Movies
    push 28h             ; unsigned int
    jmp 0x0053123C
.No_Movies:
    mov dword [0x00884E2C], 1
    jmp 0x00531269

_Init_Game_NoCD_Check:
    cmp byte [var.IsNoCD], 1
    jz 0x0052C5BF
    cmp eax, ebx
    jnz 0x0052C5BF
    jmp 0x0052C3BB 

_CD_NeverAsk:
    cmp byte [var.IsNoCD], 0
    jz .Normal_Code

.NoCD:
    mov al, 1
    jmp 0x004791EA ; jump to retn instruction

.Normal_Code:
    push ebx
    push esi
    push edi
    mov edi, ecx
    jmp 0x00479115

_CD_AlwaysAvailable:
    cmp byte [var.IsNoCD], 0
    jz .Normal_Code

.NoCD:
    mov al, 1
    jmp 0x00479109 ; jump to retn instruction

.Normal_Code:
    mov eax, [esp+4] ; arg_0
    cmp eax, 0FFFFFFFEh
    jmp 0x004790E7

_CD_AlwaysFindYR:
    cmp byte [var.IsNoCD], 0
    jz .Normal_Code

.NoCD: 
    mov  eax, 2
    jmp 0x004A8265 ; jump to retn instruction

.Normal_Code:
    sub esp, 120h
    jmp 0x004A80D6
 
@JMP 0x0052C5D3 _Init_Game_Check_Spawn_Arg_No_Intro
@JMP 0x0052D9A0 _Select_Game_Init_Spawner
@JMP 0x004FCBD0 _HouseClass__Flag_To_Lose_RETN_Patch ; for debugging
@JMP 0x00687F15 _Assign_Houses_Do_Spawner_Stuff
@JMP 0x00688378 _Assign_Houses_Epilogue_Do_Spawner_Stuff

@JMP 0x00501721 _Dont_Do_Alliances_At_Game_Start
@JMP 0x00686A9E _More_Alliances_Crap
@JMP 0x005D74A0 _Teams_Alliances_Stuff

_Teams_Alliances_Stuff:
    push ecx
    mov edx, [HouseClassArray_Count]
    
    cmp dword [var.SpawnerActive], 1
    jz .Ret
    
    jmp 0x005D74A7
    
.Ret:
    mov al, 1
    jmp 0x005D7548


_More_Alliances_Crap:
    mov ecx, [HouseClassArray]
 
    cmp dword [var.SpawnerActive], 1
    jz 0x00686AC6
    
    jmp 0x00686AA4


_Dont_Do_Alliances_At_Game_Start:
    cmp dword [var.SpawnerActive], 1
    jz .Skip

.Normal_Code:
    test cl, cl
    push 0
    push eax
    mov ecx, esi
    jmp 0x00501728

.Skip:
    jmp 0x00501736
    
_Dont_Make_Enemy_At_Game_Start:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code

    add esp, 8
    jmp 0x0050172F

.Normal_Code:
    call 0x004F9F90 ; HouseClass::Make_Enemy
    jmp 0x0050172F
    
_Assign_Houses_Epilogue_Do_Spawner_Stuff:
    cmp dword [var.SpawnerActive], 0
    jz .Ret

    call Load_Predetermined_Alliances

.Ret:
    pop edi
    pop esi
    add esp, 4Ch
    jmp 0x0068837D

_Assign_Houses_Do_Spawner_Stuff:
    pushad
    
    cmp dword [var.SpawnerActive], 0
    jz .Ret
    
    call Load_Selectable_Countries
    call Load_Selectable_Handicaps
    call Load_Selectable_Colors
    call Load_Selectable_Spawns
    
    ; Make sure players aren't the same team by default
    ; Spawner uses a different system to set up teams
    mov dword [PlayersTeams+0], -1
    mov dword [PlayersTeams+4], -1
    mov dword [PlayersTeams+8], -1
    mov dword [PlayersTeams+12], -1
    mov dword [PlayersTeams+16], -1
    mov dword [PlayersTeams+20], -1
    mov dword [PlayersTeams+24], -1
    mov dword [PlayersTeams+28], -1

.Ret:
    popad
    mov edi, [NameNodes_CurrentSize]
    jmp  0x00687F1B

_HouseClass__Flag_To_Lose_RETN_Patch:
    retn 4

Initialize_Spawn:
%push
    push ebp
    mov ebp,esp
    sub esp,128

%define TempBuf     ebp-128

    cmp dword [var.IsSpawnArgPresent], 0
    je .Exit_Error
    
    cmp dword [var.SpawnerActive], 1
    jz .Ret_Exit
    
    mov dword [var.SpawnerActive], 1
    mov dword [var.PortHack], 1 ; default enabled
    
    call Load_SPAWN_INI
    cmp eax, 0
    jz .Exit_Error
    
    ; get pointer to inet_addr
    push str_wsock32_dll
    call [LoadLibraryA]

    push str_inet_addr
    push eax
    call [GetProcAddress]

    mov [var.inet_addr], eax

    mov byte [GameActive], 1 ; needs to be set here or the game gets into an infinite loop trying to create spawning units

    ; set session 
    mov dword [SessionType], 5
    

    SpawnINI_Get_Int str_Settings, str_UnitCount, 0
    mov dword [UnitCount], eax
      
    SpawnINI_Get_Int str_Settings, str_TechLevel, 10
    mov dword [TechLevel], eax
      
    SpawnINI_Get_Int str_Settings, str_AIPlayers, 0
    mov dword [AIPlayers], eax
   
    SpawnINI_Get_Int str_Settings, str_AIDifficulty, 1   
    mov dword [AIDifficulty], eax
      
    SpawnINI_Get_Bool str_Settings, str_BuildOffAlly, 0
    mov dword [BuildOffAlly], eax
    
    SpawnINI_Get_Bool str_Settings, str_SuperWeapons, 1
    mov byte [SuperWeapons], al
    
    SpawnINI_Get_Bool str_Settings, str_HarvesterTruce, 0
    mov byte [HarvesterTruce], al
      
    SpawnINI_Get_Bool str_Settings, str_BridgeDestroy, 1 
    mov byte [BridgeDestroy], al
      
    SpawnINI_Get_Bool str_Settings, str_FogOfWar, 0
    mov byte [FogOfWar], al     
 
    SpawnINI_Get_Bool str_Settings, str_Crates, 0
    mov byte [Crates], al
     
    SpawnINI_Get_Bool str_Settings, str_ShortGame, 0
    mov byte [ShortGame], al     
  
    SpawnINI_Get_Bool str_Settings, str_Bases, 1
    mov byte [Bases], al      
 
    SpawnINI_Get_Bool str_Settings, str_MCVRedeploy, 1
    mov byte [MCVRedeploy], al   
      
    SpawnINI_Get_Int str_Settings, str_Credits, 10000
    mov dword [Credits], eax   
      
    SpawnINI_Get_Int str_Settings, str_GameSpeed, 0
    mov dword [GameSpeed], eax
     
    SpawnINI_Get_Bool str_Settings, str_MultiEngineer, 0
    mov byte [MultiEngineer], al
    
    ; tunnel ip
    lea eax, [TempBuf]
    SpawnINI_Get_String str_Tunnel, str_Ip, str_Empty, eax, 32

    lea eax, [TempBuf]
    push eax
    call [var.inet_addr]
    mov [var.TunnelIp], eax

    ; tunnel port
    SpawnINI_Get_Int str_Tunnel, str_Port, 0
    and eax, 0xffff
    push eax
    call htonl
    mov [var.TunnelPort], eax

    ; tunnel id 
    SpawnINI_Get_Int str_Settings, str_Port, 0
    and eax, 0xffff
    push eax
    call htonl
    mov [var.TunnelId], eax

    cmp dword [var.TunnelPort],0
    jne .nosetport
    SpawnINI_Get_Int str_Settings, str_Port, 1234
    mov word [ListenPort], ax
.nosetport:

    mov ecx, SessionClass_this
    call SessionClass__Read_Scenario_Descriptions
    
    call Add_Human_Player
    call Add_Human_Opponents
    
    call Load_Spectators
    
    ; scenario
    lea eax, [ScenarioName] ; FIXME: name this
    SpawnINI_Get_String str_Settings, str_Scenario, str_Empty, eax, 32
    
    ; Needs to be done after SessionClass is set, or the seed value will be overwritten
    ; inside the Init_Random() call if sessiontype == SKIRMISH
    SpawnINI_Get_Int str_Settings, str_Seed, 0
    mov dword [Seed], eax
    call Init_Random
    
    ; Initialize networking
    
    push 3F5CCh
    call new
    add esp, 4
    
    mov ecx, eax
    call UDPInterfaceClass__UDPInterfaceClass
    
    mov [WinsockInterface_this], eax
    
    mov ecx, [WinsockInterface_this]
    call WinsockInterfaceClass__Init
    
    push 0
    mov ecx, [WinsockInterface_this]
    call UDPInterfaceClass__Open_Socket
    
    mov ecx, [WinsockInterface_this]
    call WinsockInterfaceClass__Start_Listening
    
    mov ecx, [WinsockInterface_this]
    call WinsockInterfaceClass__Discard_In_Buffers
    
    mov ecx, [WinsockInterface_this]
    call WinsockInterfaceClass__Discard_Out_Buffers
    
    mov ecx, IPXManagerClass_this
    push 1
    push 258h
    push 0FFFFFFFFh
    push 3Ch
    call IPXManagerClass__Set_Timing
    
    mov dword [MaxAhead], 9
    mov dword [MaxMaxAhead], 0
    MOV dword [FrameSendRate], 3
    mov dword [LatencyFudge], 0
    mov dword [RequestedFPS], 60
    mov dword [ProtocolVersion], 2

    call Init_Network
    
    mov dword eax, [NameNodes_CurrentSize]
    mov dword [HumanPlayers], eax
    
    ; Load HouseTypes background and stuff for scenario loading screen
    call Load_Sides_Stuff
    
    call 0x0061F210 ; Load_Country_Flags_And_Stuff
    
    SpawnINI_Get_Int str_Settings, str_GameMode, 1
    mov ecx, eax
    call Set_Game_Mode
    mov [GameMode], eax
        
    ; start scenario 
    push -1 
    xor edx, edx 
    mov ecx, ScenarioName
    call Start_Scenario

    ; HACK: If SessonType was set to WOL then set it to LAN now
    ; We had to set SessionType to WOL to make sure players connect
    ; while Start_Scenario was being executed
    
    cmp dword [SessionType], 4
    jnz .Dont_Set_SessionType_To_Lan
    
    mov dword [SessionType], 3
 
.Dont_Set_SessionType_To_Lan:
 
    mov ecx, SessionClass_this
    call SessionClass__Create_Connections

    mov ecx, IPXManagerClass_this
    push 1
    push 258h
    push 0FFFFFFFFh
    push 3Ch
    call IPXManagerClass__Set_Timing


    mov ecx, [WWMouseClas_Mouse] 
    mov edx, [ecx] 
    call dword [edx+0Ch]
    
    mov     ecx, [0x0088730C]
    push    0
    mov     eax, [ecx]
    call    dword [eax+18h]
    
    mov     edx, [0x0088730C]
    mov     cl, 1
    push    0
    call    0x004F4780
    
    mov ecx, [WWMouseClas_Mouse] 
    mov edx, [ecx] 
    call dword [edx+10h]
    
    mov eax, [0x0088730C]
    mov [0x00887314], eax
    
    push 0 
    push 13h 
    mov ecx, MouseClass_Map 
    call 0x005BDC80
       
    mov ecx, MouseClass_Map 
    call 0x005BDAA0 
       
    push 1 
    mov ecx, MouseClass_Map 
    call 0x006D04F0
    
    push    0
    mov     ecx, MouseClass_Map
    call    0x004F42F0
    
.Ret:   
    mov eax, 1
    jmp .exit
.Ret_Exit:
    mov eax, 0
    jmp .exit
.Exit_Error:
    mov eax, -1
    jmp .exit

.exit:
    mov esp,ebp
    pop ebp
    retn
%pop

_Select_Game_Init_Spawner:
    call Initialize_Spawn
    cmp eax,-1
    ; if spawn not initialized, go to main menu
    je .Normal_Code
    
    retn
    
.Normal_Code:
    sub esp, 110h
    jmp 0x0052D9A6

_Init_Game_Check_Spawn_Arg_No_Intro:
    pushad

 ;   call [GetCommandLineA]
 ;   push str_SpawnArg
 ;   push eax
 ;   call strstr_
 ;   add esp, 8
 ;   xor ebx, ebx
 ;   cmp eax, 0  
;    setne bl
    
    mov ebx, 1 ; HACK DONT CHECK -SPAWN
    
    mov [var.IsSpawnArgPresent], ebx
    popad
    
    cmp dword [var.IsSpawnArgPresent], 0
    jz .Normal_Code


    jmp 0x0052C5F8
    
.Normal_Code:
    push 0x00826064  ;  offset a___ok   ; " ...OK\n"
    jmp 0x0052C5D8

Load_SPAWN_INI:
%push
    push ebp
    mov ebp,esp
    sub esp,128

%define TempFileClass ebp-128

    ; initialize FileClass
    push str_spawn_ini
    lea ecx, [TempFileClass]
    call FileClass__FileClass

    ; check ini exists
    lea ecx, [TempFileClass]
    xor edx, edx
    push edx
    call FileClass__Is_Available
    test al, al
    je .error

    ; initialize INIClass
    mov ecx, var.INIClass_SPAWN
    call INIClass__INIClass

    ; load FileClass to INIClass
    push 0
    push 0
    lea eax, [TempFileClass]
    push eax
    Mov ecx, var.INIClass_SPAWN
    call INIClass__Load
    
    mov eax, 1
    jmp .exit

.error:
    mov eax, 0
.exit:
    mov esp,ebp
    pop ebp
    retn
%pop
    
Add_Human_Player:      
%push
    push ebp
    mov ebp,esp
    sub esp,256

%define TempPtr ebp-4
%define NameBuf ebp-256

    push 1
    push 0x85
    call calloc
       
    mov esi, eax 

    lea ecx, [esi+28h] 
    call IPXAddressClass__IPXAddressClass 

;    lea eax, [esi]
;    SpawnINI_Get_String str_Settings, str_Name, str_Empty, eax, 0x14
    
    lea eax, [NameBuf]
    SpawnINI_Get_String str_Settings, str_Name, str_Empty, eax, 0x28
    
    lea eax, [NameBuf]
    push 0x28
    push eax
    push esi
    call mbstowcs_ 
       
    ; Player side
    SpawnINI_Get_Int str_Settings, str_Side, 0
    mov dword [esi+0x4B], eax ; side

    ; Invert AL to set byte related to what sidebar and speech graphics to load
    cmp al, 1
    jz .Set_AL_To_Zero
        
    mov al, 1
    jmp .Past_AL_Invert
        
.Set_AL_To_Zero:
    mov al, 0
        
.Past_AL_Invert:        
;    mov byte [0x7E2500], al ; For side specific mix files loading and stuff, without sidebar and speech hack

    SpawnINI_Get_Int str_Settings, str_Color, 0
    mov dword [esi+0x53], eax  ; color
    mov dword [PlayerColor], eax

    mov dword [esi+0x73], -1    
    
    mov [TempPtr], esi 
    lea eax, [TempPtr] 
    push eax 
    mov ecx, NameNodeVector
    call NameNodeVector_Add

    mov esp,ebp
    pop ebp
    retn
%pop

Load_Sides_Stuff:
    mov eax, [0x00887048]
    mov ecx, [0x008871E0]
    push eax
    mov dword [esp+8], 0FFFFFFFFh
    call 0x006722F0
    mov ecx, [0x00887048]
    push ecx
    mov ecx, [0x008871E0]
    call 0x00672440
    mov eax, [0x00A83CA8]
    xor esi, esi
    test eax, eax
    jle .Ret

.Loop:
    mov edx, [0x00A83C9C] ; HouseTypesArray?
    mov ecx, [edx+esi*4]
    mov edx, [0x00887048]
    push edx
    mov eax, [ecx]
    call dword [eax+64h]
    mov eax, [0x00A83CA8]
    inc esi
    cmp esi, eax
    jl .Loop

.Ret:
    retn

Add_Human_Opponents:
    Add_Human_Opponent 1, str_Other1
    Add_Human_Opponent 2, str_Other2
    Add_Human_Opponent 3, str_Other3
    Add_Human_Opponent 4, str_Other4
    Add_Human_Opponent 5, str_Other5
    Add_Human_Opponent 6, str_Other6
    Add_Human_Opponent 7, str_Other7
retn    

Add_Human_Opponent_:
%push
    push ebp
    mov ebp,esp
    sub esp,128+128+4+4

%define TempBuf         ebp-128
%define TempPtr         ebp-128-128-4
%define CurrentOpponent ebp-128-128-4-4

    ; copy opponents
    mov ecx, eax
    mov dword [CurrentOpponent], ecx
    
    push 1
    push 0x85
    call calloc
      
    mov esi, eax 
    lea ecx, [esi+28h] 
    call IPXAddressClass__IPXAddressClass
      
    lea eax, [TempBuf]
    mov ecx, [var.OtherSection]
    SpawnINI_Get_String ecx, str_Name, str_Empty, eax, 0x28
    
    lea eax, [TempBuf]
    mov eax, [eax]
    test eax, eax
    ; if no name present for this section, this is the last
    je .Exit
    
    lea eax, [TempBuf]
    push 0x28
    push eax
    push esi
    call mbstowcs_ 
    
    mov ecx, [var.OtherSection]
    SpawnINI_Get_Int ecx, str_Side, -1
    mov dword [esi+0x4B], eax ; side
        
    cmp eax,-1
    je .Exit

    mov ecx, [var.OtherSection]
    SpawnINI_Get_Int ecx, str_Color, -1
    mov dword [esi+0x53], eax  ; color
        
    cmp eax,-1
    je .Exit
     
    mov eax, 1
    mov dword [SessionType], 4 ; HACK: SessonType set to WOL, will be set to LAN later

    ; set addresses to indexes for send/receive hack
    mov [esi + 0x28 + SpawnAddress.pad1], word 0
    mov ecx, dword [CurrentOpponent]
    mov [esi + 0x28 + SpawnAddress.id], ecx
    mov [esi + 0x28 + SpawnAddress.pad2], word 0

    lea eax, [TempBuf]
    mov ecx, [var.OtherSection]
    SpawnINI_Get_String ecx, str_Ip, str_Empty, eax, 32
    
    lea eax, [TempBuf]
    push eax
    call [var.inet_addr]
    
    mov ecx, dword [CurrentOpponent]
    dec ecx
    mov [ecx * ListAddress_size + var.AddressList + ListAddress.ip], eax
    
    mov ecx, [var.OtherSection]
    SpawnINI_Get_Int ecx, str_Port, 0
    and eax, 0xffff

    push eax
    call htonl
    shr eax,16

    ; disable PortHack if different port than own
    cmp ax, [ListenPort]
    je .samePort
    mov dword [var.PortHack], 0    
.samePort:

    mov ecx, dword [CurrentOpponent]
    dec ecx
    mov [ecx * ListAddress_size + var.AddressList + ListAddress.port], ax

    mov dword [esi+0x73], -1 
    
    mov byte [esi+0x1E], 1
       
    mov [TempPtr], esi 
    lea eax, [TempPtr] 
    push eax 
    mov ecx, NameNodeVector ; FIXME: name this
    call NameNodeVector_Add ; FIXME: name this
      
 ;   jmp .next_opp
.Exit:
    mov esp,ebp
    pop ebp
    retn
%pop
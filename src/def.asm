; winapi
%define sendto          0x007C89B0
%define recvfrom        0x007C89AA
%define htonl           0x007C8962
%define GetCommandLineA 0x007E1280
%define strstr_         0x007CA4B0
%define LoadLibraryA    0x007E1220
%define GetProcAddress  0x007E1250
%define _sprintf        0x007C8EF4
%define mbstowcs_       0x007CC2AC

; Memory
%define new                         0x007C8E17
%define calloc                      0x007D3374

; House
%define HouseClassArray             0x00A8022C
%define HouseClassArray_Count       0x00A80238
%define HouseTypesArray             0x00A83C9C
;%define HouseClass__Assign_Handicap 0x004BB460
%define HouseClass__Make_Ally       0x004F9B50
%define Assign_Houses               0x00687F10
;%define Get_MP_Color                0x005EEF70

%define PlayersCountries            0x00A8B29C
%define PlayersColors               0x00A8B2BC
%define PlayersSpawns               0x00A8B2DC
%define PlayersHandicaps            0x00A8B27C
%define PlayersTeams                0x00A8B2FC

; INI
%define INIClass__INIClass          0x00535B30
%define INIClass__Load              0x004741F0
%define INIClass__GetBool           0x005295F0
%define INIClass__GetInt            0x005276D0
%define INIClass__GetString         0x00528A10

; File
%define FileClass__FileClass        0x004739F0
%define FileClass__Is_Available     0x00473C50

; Session
%define SessionClass_this           0x00A8B238
%define SessionClass__Create_Connections    0x00697B70
%define Set_Game_Mode               0x005D5F30
%define GameActive                  0x00A8E9A0
%define SessionType                 0x00A8B238
%define UnitCount                   0x00A8B270
%define TechLevel                   0x00822CF4
%define AIPlayers                   0x00A8B274
%define AIDifficulty                0x00A8B278
%define BuildOffAlly                0x00A8B264
%define BridgeDestroy               0x00A8B260
%define FogOfWar                    0x00A8B31F
%define Crates                      0x00A8B261
%define ShortGame                   0x00A8B262
%define Bases                       0x00A8B258
%define MCVRedeploy                 0x00A8B320
%define Credits                     0x00A8B25C
%define HarvesterTruce              0x00A8B31D
%define SuperWeapons                0x00A8B263
%define GameSpeed                   0x00A8B268
%define MultiEngineer               0x00A8B26C
%define PlayerColor                 0x00A8B394
%define GameMode                    0x00A8B23C

; Network
%define ListenPort                  0x00841F30

; Random
%define Seed                        0x00A8ED94
%define Init_Random                 0x0052FC20

; Message
;%define MessageListClass_this           0x007E2C34
;%define PlayerPtr                       0x007E2284
;%define MessageListClass__Add_Message   0x00572FE0
;%define Get_Message_Delay_Or_Duration   0x006B2330

; Network
%define UDPInterfaceClass__UDPInterfaceClass        0x007B2DB0
%define WinsockInterface_this                       0x00887628
%define WinsockInterfaceClass__Init                 0x007B1DE0
%define UDPInterfaceClass__Open_Socket              0x007B30B0
%define WinsockInterfaceClass__Start_Listening      0x007B1BC0
%define WinsockInterfaceClass__Discard_In_Buffers   0x007B1CA0
%define WinsockInterfaceClass__Discard_Out_Buffers  0x007B1D10
%define IPXManagerClass_this                        0x00A8E9C0
%define IPXManagerClass__Set_Timing                 0x00540C60
%define IPXAddressClass__IPXAddressClass            0x0053ECB0


%define MaxAhead                                    0x00A8B550
%define MaxMaxAhead                                 0x00A8B568
%define FrameSendRate                               0x00A8B554
%define LatencyFudge                                0x00A8DB9C
%define RequestedFPS                                0x00A8B558
%define ProtocolVersion                             0x00A8B24C

%define Init_Network                                0x005DA6C0
%define NameNodes_CurrentSize                       0x00A8DA84
%define HumanPlayers                                0x00A8B54C

; Scenario
%define ScenarioName                                0x00A8B8E0
%define Start_Scenario                              0x00683AB0
%define NameNodeVector                              0x00A8DA74
%define NameNode                                    0x00A8DA78
%define NameNodeVector_Add                          0x00477EC0
%define SessionClass__Read_Scenario_Descriptions    0x00699980


; Save games
;%define Load_Game                                   0x005D6910

; Mouse
%define WWMouseClas_Mouse                           0x00887640
%define MouseClass_Map                              0x0087F7E8

; definitions of common structures
struc sockaddr_in
    .sin_family     RESW 1
    .sin_port       RESW 1
    .sin_addr       RESD 1
    .sin_zero       RESB 8
endstruc

struc ListAddress
    .port:      RESD 1
    .ip:        RESD 1
endstruc

struc NetAddress
    .port:      RESD 1
    .ip:        RESD 1
    .zero:      RESW 1
endstruc

struc SpawnAddress
    .pad1:      RESD 1
    .id:        RESD 1
    .pad2:      RESW 1
endstruc

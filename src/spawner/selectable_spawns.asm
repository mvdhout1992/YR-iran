Load_Selectable_Spawns:
    SpawnINI_Get_Int str_SpawnLocations, str_Multi1, -1
    mov dword [PlayersSpawns+0], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi2, -1
    mov dword [PlayersSpawns+4], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi3, -1
    mov dword [PlayersSpawns+8], eax
      
    SpawnINI_Get_Int str_SpawnLocations, str_Multi4, -1
    mov dword [PlayersSpawns+12], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi5, -1
    mov dword [PlayersSpawns+16], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi6, -1
    mov dword [PlayersSpawns+20], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi7, -1
    mov dword [PlayersSpawns+24], eax
    
    SpawnINI_Get_Int str_SpawnLocations, str_Multi8, -1
    mov dword [PlayersSpawns+28], eax

    retn
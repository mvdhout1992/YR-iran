Load_Selectable_Colors:
    SpawnINI_Get_Int str_HouseColors, str_Multi1, -1
    mov dword [PlayersColors+0], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi2, -1
    mov dword [PlayersColors+4], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi3, -1
    mov dword [PlayersColors+8], eax
      
    SpawnINI_Get_Int str_HouseColors, str_Multi4, -1
    mov dword [PlayersColors+12], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi5, -1
    mov dword [PlayersColors+16], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi6, -1
    mov dword [PlayersColors+20], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi7, -1
    mov dword [PlayersColors+24], eax
    
    SpawnINI_Get_Int str_HouseColors, str_Multi8, -1
    mov dword [PlayersColors+28], eax

    retn
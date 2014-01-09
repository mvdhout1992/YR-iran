Load_Selectable_Countries:
    SpawnINI_Get_Int str_HouseCountries, str_Multi1, -1
    mov dword [PlayersCountries+0], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi2, -1
    mov dword [PlayersCountries+4], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi3, -1
    mov dword [PlayersCountries+8], eax
      
    SpawnINI_Get_Int str_HouseCountries, str_Multi4, -1
    mov dword [PlayersCountries+12], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi5, -1
    mov dword [PlayersCountries+16], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi6, -1
    mov dword [PlayersCountries+20], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi7, -1
    mov dword [PlayersCountries+24], eax
    
    SpawnINI_Get_Int str_HouseCountries, str_Multi8, -1
    mov dword [PlayersCountries+28], eax

    retn
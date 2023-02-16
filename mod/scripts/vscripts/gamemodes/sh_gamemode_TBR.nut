global function TBR_init
global const string GAMEMODE_BR_SOLO = "BR_SOLO"
global const string GAMEMODE_BR_LOBBY = "BR_LOBBY"

void function TBR_init()
{   
    AddCallback_OnCustomGamemodesInit( CreateGamemodeBR_LOBBY )
    AddCallback_OnCustomGamemodesInit( CreateGamemodeBR_SOLO )
    AddCallback_OnRegisteringCustomNetworkVars( BRRegisterNetworkVars )
}

void function CreateGamemodeBR_SOLO()
{
    GameMode_Create( GAMEMODE_BR_SOLO)
    GameMode_SetName( GAMEMODE_BR_SOLO, "#PL_BR_SOLO" )
    GameMode_SetDesc( GAMEMODE_BR_SOLO, "#PL_BR_SOLO_desc" )
    GameMode_SetIcon( GAMEMODE_BR_SOLO, $"vgui/burncards/burncard_group_icon_weapons" ) //FFA_MODE_ICON
    GameMode_SetGameModeAnnouncement( GAMEMODE_BR_SOLO, "ffa_modeDesc" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_BR_SOLO, 100, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_BR_SOLO, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
    GameMode_AddScoreboardColumnData( GAMEMODE_BR_SOLO, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
    GameMode_SetColor( GAMEMODE_BR_SOLO, [147, 204, 57, 255] )

    AddPrivateMatchMode( GAMEMODE_BR_SOLO)
    /*
    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "min_players", GetCurrentPlaylistVarInt("min_players", 2).tostring())

    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_EnableDevMod", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_EnableDevMod", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_canSpawnTitan", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_canSpawnTitan", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_SOLO_canUseBoost", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SOLO_canUseBoost", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "BR_SOLO_IntroLength", GetCurrentPlaylistVarInt("BR_SOLO_IntroLength", 0).tostring())
    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "BR_SOLO_NumChest", GetCurrentPlaylistVarInt("BR_SOLO_NumChest", 0).tostring())

    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_SOLO_SpawnWithMainWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SOLO_SpawnWithMainWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_SOLO_SpawnWithSecondaryWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SOLO_SpawnWithSecondaryWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR_SOLO", "BR_SOLO_SpawnWithAntiTitanWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SOLO_SpawnWithAntiTitanWeapon", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "BR_SOLO_SpawnMainWeapon", GetCurrentPlaylistVarString("BR_SOLO_SpawnMainWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "BR_SOLO_SpawnSecondaryWeapon", GetCurrentPlaylistVarString("BR_SOLO_SpawnSecondaryWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_BR_SOLO", "BR_SOLO_SpawnAntiTitanWeapon", GetCurrentPlaylistVarString("BR_SOLO_SpawnAntiTitanWeapon", ""))
    */
    GameMode_SetDefaultScoreLimits( GAMEMODE_BR_SOLO, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_BR_SOLO, GamemodeBR_SOLO_Init )
			//GameMode_AddServerInit( GAMEMODE_BR_SOLO, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_BR_SOLO, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_BR_SOLO, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_BR_SOLO, ClGamemodeBR_SOLO_Init )
			GameMode_AddClientInit( GAMEMODE_BR_SOLO, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_BR_SOLO, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_BR_SOLO, GamemodeFFA_Dialogue_Init )
	#endif
}

void function CreateGamemodeBR_LOBBY()
{
    GameMode_Create( GAMEMODE_BR_LOBBY )
    GameMode_SetName( GAMEMODE_BR_LOBBY, "#PL_BR_LOBBY" )
    GameMode_SetDesc( GAMEMODE_BR_LOBBY, "#PL_BR_LOBBY_desc" )
    GameMode_SetIcon( GAMEMODE_BR_LOBBY, $"vgui/burncards/burncard_group_icon_weapons" )
    GameMode_SetGameModeAnnouncement( GAMEMODE_BR_LOBBY, "ffa_modeDesc" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_BR_LOBBY, 1000, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_BR_LOBBY, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 ) // dont fuck with it
    GameMode_AddScoreboardColumnData( GAMEMODE_BR_LOBBY, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 ) // dont fuck with it
    GameMode_SetColor( GAMEMODE_BR_LOBBY, [147, 204, 57, 255] ) // dont fuck with it

    AddPrivateMatchMode( GAMEMODE_BR_LOBBY )

    GameMode_SetDefaultScoreLimits( GAMEMODE_BR_LOBBY, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_BR_LOBBY, GamemodeBR_LOBBY_Init )
			GameMode_AddServerInit( GAMEMODE_BR_LOBBY, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_BR_LOBBY, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_BR_LOBBY, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_BR_LOBBY, ClGamemodeBR_LOBBY_Init )
			GameMode_AddClientInit( GAMEMODE_BR_LOBBY, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_BR_LOBBY, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_BR_LOBBY, GamemodeFFA_Dialogue_Init )
	#endif
}


void function BRRegisterNetworkVars()
{
    if ( GAMETYPE == GAMEMODE_BR_SOLO) {
        Remote_RegisterFunction( "GameNumPlayerLeftAnnouncement" )
        Remote_RegisterFunction( "Cl_CreateLight" )
    }
    else if (GAMETYPE == GAMEMODE_BR_LOBBY) {
        Remote_RegisterFunction( "Cl_OnWaitingVote" )
        Remote_RegisterFunction( "Cl_EnoughPlayerToStart" )
    }
    Remote_RegisterFunction("Cl_TEST")
}


global function TD_init
global const string GAMEMODE_TD_SOLO = "TD_SOLO"
global const string GAMEMODE_TD_LOBBY = "TD_LOBBY"

void function TD_init()
{   
    AddCallback_OnCustomGamemodesInit( CreateGamemodeTD_LOBBY )
    AddCallback_OnCustomGamemodesInit( CreateGamemodeTD_SOLO )
    AddCallback_OnRegisteringCustomNetworkVars( TDRegisterNetworkVars )
}

void function CreateGamemodeTD_SOLO()
{
    GameMode_Create( GAMEMODE_TD_SOLO)
    GameMode_SetName( GAMEMODE_TD_SOLO, "#PL_TD_SOLO" )
    GameMode_SetDesc( GAMEMODE_TD_SOLO, "#PL_TD_SOLO_desc" )
    GameMode_SetIcon( GAMEMODE_TD_SOLO, FFA_MODE_ICON ) //FFA_MODE_ICON //$"ui/menu/playlist/tdm" //$"vgui/burncards/burncard_group_icon_weapons"
    GameMode_SetGameModeAnnouncement( GAMEMODE_TD_SOLO, "ffa_modeDesc" ) //ffa_modeDesc
    GameMode_SetDefaultTimeLimits( GAMEMODE_TD_SOLO, 100, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_TD_SOLO, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
    GameMode_AddScoreboardColumnData( GAMEMODE_TD_SOLO, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
    GameMode_SetColor( GAMEMODE_TD_SOLO, [147, 204, 57, 255] )

    AddPrivateMatchMode( GAMEMODE_TD_SOLO)

    //AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "min_players", GetCurrentPlaylistVarInt("min_players", 2).tostring())

    //AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TTD_EnableDevMod", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TTD_EnableDevMod", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TD_canSpawnTitan", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TD_canSpawnTitan", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TD_canUseBoost", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TD_canUseBoost", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "TD_IntroLength", GetCurrentPlaylistVarInt("TD_IntroLength", 0).tostring())
    AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "TD_MinNumChest", GetCurrentPlaylistVarInt("TD_MinNumChest", 0).tostring())

    AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TD_SpawnWithMainWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TD_SpawnWithMainWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TD_SpawnWithSecondaryWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TD_SpawnWithSecondaryWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TD_SOLO", "TD_SpawnWithAntiTitanWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TD_SpawnWithAntiTitanWeapon", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "TD_SpawnMainWeapon", GetCurrentPlaylistVarString("TD_SpawnMainWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "TD_SpawnSecondaryWeapon", GetCurrentPlaylistVarString("TD_SpawnSecondaryWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_TD_SOLO", "TD_SpawnAntiTitanWeapon", GetCurrentPlaylistVarString("TD_SpawnAntiTitanWeapon", ""))

    GameMode_SetDefaultScoreLimits( GAMEMODE_TD_SOLO, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_TD_SOLO, GamemodeTD_SOLO_Init )
			//GameMode_AddServerInit( GAMEMODE_TD_SOLO, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_TD_SOLO, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_TD_SOLO, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_TD_SOLO, ClGamemodeTD_SOLO_Init )
			GameMode_AddClientInit( GAMEMODE_TD_SOLO, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_TD_SOLO, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_TD_SOLO, GamemodeFFA_Dialogue_Init )
	#endif
}

void function CreateGamemodeTD_LOBBY()
{
    GameMode_Create( GAMEMODE_TD_LOBBY )
    GameMode_SetName( GAMEMODE_TD_LOBBY, "#PL_TD_LOBBY" )
    GameMode_SetDesc( GAMEMODE_TD_LOBBY, "#PL_TD_LOBBY_desc" )
    GameMode_SetIcon( GAMEMODE_TD_LOBBY, $"vgui/burncards/burncard_group_icon_weapons" )
    GameMode_SetGameModeAnnouncement( GAMEMODE_TD_LOBBY, "ffa_modeDesc" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_TD_LOBBY, 1000, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_TD_LOBBY, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 ) // dont fuck with it
    GameMode_AddScoreboardColumnData( GAMEMODE_TD_LOBBY, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 ) // dont fuck with it
    GameMode_SetColor( GAMEMODE_TD_LOBBY, [147, 204, 57, 255] ) // dont fuck with it

    AddPrivateMatchMode( GAMEMODE_TD_LOBBY )

    GameMode_SetDefaultScoreLimits( GAMEMODE_TD_LOBBY, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_TD_LOBBY, GamemodeTD_LOBBY_Init )
			GameMode_AddServerInit( GAMEMODE_TD_LOBBY, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_TD_LOBBY, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_TD_LOBBY, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_TD_LOBBY, ClGamemodeTD_LOBBY_Init )
			GameMode_AddClientInit( GAMEMODE_TD_LOBBY, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_TD_LOBBY, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_TD_LOBBY, GamemodeFFA_Dialogue_Init )
	#endif
}


void function TDRegisterNetworkVars()
{
    if ( GAMETYPE == GAMEMODE_TD_SOLO) {
        Remote_RegisterFunction( "GameNumPlayerLeftAnnouncement" )
        Remote_RegisterFunction( "Cl_CreateLight" )
        Remote_RegisterFunction( "SetAllowToShowScoreboard" )
    }
    else if (GAMETYPE == GAMEMODE_TD_LOBBY) {
        Remote_RegisterFunction( "Cl_OnWaitingVote" )
        Remote_RegisterFunction( "Cl_EnoughPlayerToStart" )
    }
    Remote_RegisterFunction("Cl_TEST")
}


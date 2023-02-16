global function BR_init
global const string GAMEMODE_BR = "BR"
global const string GAMEMODE_BR_LOBBY = "BR_LOBBY"

void function BR_init()
{   
    AddCallback_OnCustomGamemodesInit( CreateGamemodeBR_Lobby )
    AddCallback_OnCustomGamemodesInit( CreateGamemodeBR )
    AddCallback_OnRegisteringCustomNetworkVars( BRRegisterNetworkVars )
}

void function CreateGamemodeBR()
{
    GameMode_Create( GAMEMODE_BR)
    GameMode_SetName( GAMEMODE_BR, "#PL_BR" )
    GameMode_SetDesc( GAMEMODE_BR, "#PL_BR_desc" )
    GameMode_SetIcon( GAMEMODE_BR, $"vgui/burncards/burncard_group_icon_weapons" ) //FFA_MODE_ICON
    GameMode_SetGameModeAnnouncement( GAMEMODE_BR, "ffa_modeDesc" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_BR, 100, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_BR, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
    GameMode_AddScoreboardColumnData( GAMEMODE_BR, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
    GameMode_SetColor( GAMEMODE_BR, [147, 204, 57, 255] )

    AddPrivateMatchMode( GAMEMODE_BR)

    AddPrivateMatchModeSettingArbitrary("#PL_BR", "min_players", GetCurrentPlaylistVarInt("min_players", 2).tostring())

    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_EnableDevMod", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_EnableDevMod", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_canSpawnTitan", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_canSpawnTitan", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_canUseBoost", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_canUseBoost", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_BR", "BR_IntroLength", GetCurrentPlaylistVarInt("BR_IntroLength", 0).tostring())
    AddPrivateMatchModeSettingArbitrary("#PL_BR", "BR_NumChest", GetCurrentPlaylistVarInt("BR_NumChest", 0).tostring())

    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_SpawnWithMainWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SpawnWithMainWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_SpawnWithSecondaryWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SpawnWithSecondaryWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_BR", "BR_SpawnWithAntiTitanWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("BR_SpawnWithAntiTitanWeapon", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_BR", "BR_SpawnMainWeapon", GetCurrentPlaylistVarString("BR_SpawnMainWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_BR", "BR_SpawnSecondaryWeapon", GetCurrentPlaylistVarString("BR_SpawnSecondaryWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_BR", "BR_SpawnAntiTitanWeapon", GetCurrentPlaylistVarString("BR_SpawnAntiTitanWeapon", ""))

    GameMode_SetDefaultScoreLimits( GAMEMODE_BR, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_BR, GamemodeBR_Init )
			//GameMode_AddServerInit( GAMEMODE_BR, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_BR, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_BR, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_BR, ClGamemodeBR_Init )
			GameMode_AddClientInit( GAMEMODE_BR, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_BR, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_BR, GamemodeFFA_Dialogue_Init )
	#endif
}

void function CreateGamemodeBR_Lobby()
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
            GameMode_AddServerInit( GAMEMODE_BR_LOBBY, GamemodeBR_Lobby_Init )
			GameMode_AddServerInit( GAMEMODE_BR_LOBBY, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_BR_LOBBY, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_BR_LOBBY, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_BR_LOBBY, ClGamemodeBR_Lobby_Init )
			GameMode_AddClientInit( GAMEMODE_BR_LOBBY, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_BR_LOBBY, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_BR_LOBBY, GamemodeFFA_Dialogue_Init )
	#endif
}


void function BRRegisterNetworkVars()
{
    if ( GAMETYPE == GAMEMODE_BR) {
        Remote_RegisterFunction( "GameNumPlayerLeftAnnouncement" )
        Remote_RegisterFunction( "Cl_CreateLight" )
    }
    else if (GAMETYPE == GAMEMODE_BR_LOBBY) {
        Remote_RegisterFunction( "Cl_OnWaitingVote" )
        Remote_RegisterFunction( "Cl_EnoughPlayerToStart" )
    }
    Remote_RegisterFunction("Cl_TEST")
}


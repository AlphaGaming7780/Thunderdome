global function TBR_init
global const string GAMEMODE_TBR= "TBR"

void function TBR_init()
{
    AddCallback_OnCustomGamemodesInit( CreateGamemodeTBR )
    AddCallback_OnRegisteringCustomNetworkVars( TBRRegisterNetworkVars )
}

void function CreateGamemodeTBR()
{
    GameMode_Create( GAMEMODE_TBR)
    GameMode_SetName( GAMEMODE_TBR, "#GAMEMODE_TBR" )
    GameMode_SetDesc( GAMEMODE_TBR, "#PL_TBR_desc" )
    GameMode_SetIcon( GAMEMODE_TBR, $"vgui/burncards/burncard_group_icon_weapons" ) //FFA_MODE_ICON
    GameMode_SetGameModeAnnouncement( GAMEMODE_TBR, "ffa_modeDesc" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_TBR, 100, 0.0 )
    GameMode_AddScoreboardColumnData( GAMEMODE_TBR, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
    GameMode_AddScoreboardColumnData( GAMEMODE_TBR, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
    GameMode_SetColor( GAMEMODE_TBR, [147, 204, 57, 255] )

    AddPrivateMatchMode( GAMEMODE_TBR)

    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_EnableDevMod", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_EnableDevMod", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_canSpawnTitan", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_canSpawnTitan", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_canUseBoost", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_canUseBoost", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_TBR", "TBR_IntroLength", GetCurrentPlaylistVarInt("TBR_IntroLength", 0).tostring())
    AddPrivateMatchModeSettingArbitrary("#PL_TBR", "TBR_NumChest", GetCurrentPlaylistVarInt("TBR_NumChest", 0).tostring())

    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_SpawnWithMainWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_SpawnWithMainWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_SpawnWithSecondaryWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_SpawnWithSecondaryWeapon", 0).tostring())
    AddPrivateMatchModeSettingEnum("#PL_TBR", "TBR_SpawnWithAntiTitanWeapon", ["#SETTING_DISABLED", "#SETTING_ENABLED"], GetCurrentPlaylistVarInt("TBR_SpawnWithAntiTitanWeapon", 0).tostring())

    AddPrivateMatchModeSettingArbitrary("#PL_TBR", "TBR_SpawnMainWeapon", GetCurrentPlaylistVarString("TBR_SpawnMainWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_TBR", "TBR_SpawnSecondaryWeapon", GetCurrentPlaylistVarString("TBR_SpawnSecondaryWeapon", ""))
    AddPrivateMatchModeSettingArbitrary("#PL_TBR", "TBR_SpawnAntiTitanWeapon", GetCurrentPlaylistVarString("TBR_SpawnAntiTitanWeapon", ""))

    GameMode_SetDefaultScoreLimits( GAMEMODE_TBR, 1000, 0 )

    #if SERVER
            GameMode_AddServerInit( GAMEMODE_TBR, GamemodeTBR_Init )
			GameMode_AddServerInit( GAMEMODE_TBR, GamemodeFFAShared_Init )
            GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_TBR, RateSpawnpoints_Generic )
            GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_TBR, RateSpawnpoints_Generic )

    #elseif CLIENT
            GameMode_AddClientInit( GAMEMODE_TBR, ClGamemodeTBR_Init )
			GameMode_AddClientInit( GAMEMODE_TBR, GamemodeFFAShared_Init )
    #endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_TBR, CompareAssaultScore )
        GameMode_AddSharedInit( GAMEMODE_TBR, GamemodeFFA_Dialogue_Init )
	#endif
}

void function TBRRegisterNetworkVars()
{
    if ( GAMETYPE != GAMEMODE_TBR)
            return

    Remote_RegisterFunction( "GameNumPlayerLeftAnnouncement" )
    Remote_RegisterFunction( "Cl_OnWaitingPlayer" )
    Remote_RegisterFunction( "Cl_ConnectedPlayer" )
}
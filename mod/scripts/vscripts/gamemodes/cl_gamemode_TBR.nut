global function ClGamemodeTBR_Init
global function GameNumPlayerLeftAnnouncement
global function cl_OpenEndGameMenu
global function WriteInGameChat
global function Cl_OnWaitingPlayer
global function Cl_ConnectedPlayer

void function ClGamemodeTBR_Init()
{
    ClGameState_RegisterGameStateAsset( $"ui/gamestate_info_ffa.rpak" )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_INTRO, "music_mp_freeagents_intro", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_INTRO, "music_mp_freeagents_intro", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_WIN, "music_mp_freeagents_outro_win", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_WIN, "music_mp_freeagents_outro_win", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_DRAW, "music_mp_freeagents_outro_lose", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_DRAW, "music_mp_freeagents_outro_lose", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LOSS, "music_mp_freeagents_outro_lose", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LOSS, "music_mp_freeagents_outro_lose", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_THREE_MINUTE, "music_mp_freeagents_almostdone", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_THREE_MINUTE, "music_mp_freeagents_almostdone", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LAST_MINUTE, "music_mp_freeagents_lastminute", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LAST_MINUTE, "music_mp_freeagents_lastminute", TEAM_MILITIA )

    AddCallback_GameStateEnter( eGameState.Postmatch, DisplayPostMatchTop3 )
}

void function Cl_OnWaitingPlayer(int TimeToWait) {
    Chat_GameWriteLine("\x1b[113m" + Localize("#TBR_WaitingTimeLeft", TimeToWait ))
}

void function Cl_ConnectedPlayer(int NumPlayer, int minPlayer) {
    Chat_GameWriteLine("\x1b[113m["+NumPlayer+"/"+minPlayer+"] " + Localize("#TBR_ConnectedPlayerDesc"))
}

void function GameNumPlayerLeftAnnouncement(int NumPlayer)
{   
    AnnouncementData announcement = Announcement_Create(Localize ("#TBR_GameNumPlayerLeftAnnouncement", NumPlayer ))
    Announcement_SetTitleColor( announcement, <1,0,0> )
    Announcement_SetPurge( announcement, true )
    Announcement_SetPriority( announcement, 200 ) //Be higher priority than Titanfall ready indicator etc
    Announcement_SetSoundAlias( announcement, SFX_HUD_ANNOUNCE_QUICK )
    Announcement_SetStyle( announcement, ANNOUNCEMENT_STYLE_QUICK )
    AnnouncementFromClass( GetLocalViewPlayer(), announcement )
}

void function cl_OpenEndGameMenu() {
    //DisplayPostMatchTop3()
    /*foreach ( entity player in GetPlayerArray() )
        ScreenFadeToBlackForever( player, 2.0 )*/

    //wait 2.0
    /*if( GetGameState() != eGameState.Postmatch )
        SetGameState( eGameState.Postmatch )*/

    Chat_GameWriteLine("Ui SPAWN")
    //RunUIScript("TBR_GetActiveMenu")
}

void function WriteInGameChat(string text) {
    Chat_GameWriteLine(text)
}
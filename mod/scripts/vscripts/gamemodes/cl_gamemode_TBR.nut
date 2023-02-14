global function ClGamemodeTBR_Init
global function ClGamemodeTBR_Lobby_Init
global function GameNumPlayerLeftAnnouncement
global function Cl_OnWaitingVote
global function Cl_EnoughPlayerToStart
global function Cl_CreateLight

entity light

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

void function Cl_OnWaitingVote(float TimeToWait) {
    Chat_GameWriteLine("\x1b[113m" + Localize("#TBR_WaitingVoteTimeLeft", TimeToWait ))
}

void function Cl_EnoughPlayerToStart(float TimeBeforeStart) {
    Chat_GameWriteLine("\x1b[113m" + Localize("#TBR_GameStartChatAnnouncement", TimeBeforeStart ))
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

void function ClGamemodeTBR_Lobby_Init()
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

void function Cl_CreateLight( float x = 0, float y = 0, float z = 0) {

    if(light != null) {
        light.Destroy()
    }

    vector origin = <x,y,z+5>
    light = CreateClientSideDynamicLight( origin, <0,0,0>, <1,1,1>, 50.0 )
}

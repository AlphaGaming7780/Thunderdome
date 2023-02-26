global function ClGamemodeBR_SOLO_Init
global function ClGamemodeBR_LOBBY_Init
global function GameNumPlayerLeftAnnouncement
global function Cl_OnWaitingVote
global function Cl_EnoughPlayerToStart
global function Cl_CreateLight
global function Cl_TEST

array<entity> light = [null, null, null]
int lightIndex = 0

void function ClGamemodeBR_SOLO_Init()
{
    ClGameState_RegisterGameStateAsset( $"ui/gamestate_info_ffa.rpak" ) // $"ui/gamestate_info_fra.rpak" // $"ui/gamestate_info_ffa.rpak"

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_INTRO, "music_mp_pilothunt_intro_flyin", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_INTRO, "music_mp_pilothunt_intro_flyin", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_WIN, "music_mp_pilothunt_epilogue_win", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_WIN, "music_mp_pilothunt_epilogue_win", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_DRAW, "music_mp_pilothunt_epilogue_win", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_DRAW, "music_mp_pilothunt_epilogue_win", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LOSS, "music_mp_pilothunt_epilogue_lose", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LOSS, "music_mp_pilothunt_epilogue_lose", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.GAMEMODE_1, "music_mp_pilothunt_almostdone", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.GAMEMODE_1, "music_mp_pilothunt_almostdone", TEAM_MILITIA )

    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LAST_MINUTE, "music_mp_pilothunt_lastminute", TEAM_IMC )
    RegisterLevelMusicForTeam( eMusicPieceID.LEVEL_LAST_MINUTE, "music_mp_pilothunt_lastminute", TEAM_MILITIA )

    AddCallback_GameStateEnter( eGameState.Postmatch, DisplayPostMatchTop3 )
}

void function Cl_OnWaitingVote(float TimeToWait) {
    Chat_GameWriteLine("\x1b[113m" + Localize("#BR_LOBBY_WaitingVoteTimeLeft", TimeToWait ))
}

void function Cl_EnoughPlayerToStart(float TimeBeforeStart) {
    Chat_GameWriteLine("\x1b[113m" + Localize("#BR_LOBBY_GameStartChatAnnouncement", TimeBeforeStart ))
}

void function GameNumPlayerLeftAnnouncement(int NumPlayer)
{   
    AnnouncementData announcement = Announcement_Create(Localize ("#BR_SOLO_GameNumPlayerLeftAnnouncement", NumPlayer ))
    Announcement_SetTitleColor( announcement, <1,0,0> )
    Announcement_SetPurge( announcement, true )
    Announcement_SetPriority( announcement, 200 ) //Be higher priority than Titanfall ready indicator etc
    Announcement_SetSoundAlias( announcement, SFX_HUD_ANNOUNCE_QUICK )
    Announcement_SetStyle( announcement, ANNOUNCEMENT_STYLE_QUICK )
    AnnouncementFromClass( GetLocalViewPlayer(), announcement )
}

void function ClGamemodeBR_LOBBY_Init()
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
    
    vector origin = <x,y,z+5>

    if(light[lightIndex] == null) {
        light[lightIndex] = CreateClientSideDynamicLight( origin, <0,0,0>, <1,1,1>, 50.0 )
    } else { 
        light[lightIndex].SetOrigin(origin)
    }

    /*if (lightIndex+ >= 3) {
        lightIndex = 0
    } else {
        lightIndex++
    }*/

    lightIndex = (lightIndex + 1) >= 3 ? 0 : (lightIndex + 1)
}

void function Cl_TEST() {
    //printt(ClGameState_GetRui())
    //RuiSetColorAlpha(ClGameState_GetRui(), "overrideColor", <1.0,1.0,1.0>, 0.0 )
    //RuiDestroyIfAlive(ClGameState_GetRui())
}

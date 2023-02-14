global function GamemodeTBR_Init
global function GamemodeTBR_Lobby_Init

float TBRIntroLength = 10
bool spawnWithMainWeapon = false
bool spawnWithSecondaryWeapon = false
bool spawnWithAntiTitanWeapon = false

string spawnMainWeapon = ""
string spawnSecondaryWeapon = ""
string spawnAntiTitanWeapon = ""

int minPlayer = 2

const array<string> BRMaps = [ "mp_forwardbase_kodai",
    //"mp_grave",
    //"mp_homestead",
    //"mp_thaw",
    //"mp_black_water_canal",
    //"mp_eden",
    //"mp_drydock",
    //"mp_crashsite3",
    "mp_complex3",
    "mp_angel_city",
    //"mp_colony02",
    //"mp_glitch",
    //"mp_lf_stacks",
    //"mp_lf_deck",
    //"mp_lf_meadow",
    //"mp_lf_traffic",
    //"mp_lf_township",
    //"mp_lf_uma",
    //"mp_relic02",
    "mp_wargames",
    //"mp_rise",
    //"mp_coliseum",
    //"mp_coliseum_column"
]

const array<string> LobbyMaps = [ //"mp_forwardbase_kodai",
    //"mp_grave",
    //"mp_homestead",
    //"mp_thaw",
    //"mp_black_water_canal",
    //"mp_eden",
    //"mp_drydock",
    //"mp_crashsite3",
    //"mp_complex3",
    //"mp_angel_city",
    //"mp_colony02",
    //"mp_glitch",
    "mp_lf_stacks",
    "mp_lf_deck",
    "mp_lf_meadow",
    "mp_lf_traffic",
    "mp_lf_township",
    "mp_lf_uma",
    //"mp_relic02",
    //"mp_wargames",
    //"mp_rise",
    //"mp_coliseum",
    //"mp_coliseum_column"
]

const array<string> mainWeapons = ["mp_weapon_rspn101",
                                    "mp_weapon_rspn101_og",
                                    "mp_weapon_hemlok",
                                    "mp_weapon_g2",
                                    "mp_weapon_vinson",
                                    //SMG
                                    "mp_weapon_hemlok_smg",
                                    "mp_weapon_car",
                                    "mp_weapon_alternator_smg",
                                    "mp_weapon_r97",
                                    //light Gun
                                    "mp_weapon_lstar",
                                    "mp_weapon_lmg",
                                    "mp_weapon_esaw"
                                    //Shotgun
                                    "mp_weapon_mastiff",
                                    "mp_weapon_shotgun",
                                    //Sniper
                                    "mp_weapon_dmr",
                                    "mp_weapon_doubletake",
                                    "mp_weapon_sniper",
                                    //Grenade Luncher
                                    "mp_weapon_epg",
                                    "mp_weapon_smr",
                                    "mp_weapon_softball",
                                    "mp_weapon_pulse_lmg",
                                    //Pistol
                                    "mp_weapon_shotgun_pistol",
                                    "mp_weapon_wingman_n",
                                    //Easter EGG weapon
                                    "mp_weapon_shotgun_doublebarrel",
                                    "mp_weapon_peacekraber"
                                ]

const array<string> secondaryWeapons = ["mp_weapon_autopistol","mp_weapon_wingman","mp_weapon_semipistol"]
const array<string> antiTitanWeapons = ["mp_weapon_rocket_launcher","mp_weapon_arc_launcher","mp_weapon_mgl"]
const array<string> boostObject = ["melee_pilot_arena", "mp_weapon_hard_cover","mp_weapon_deployable_cover","mp_weapon_satchel","mp_weapon_frag_drone","mp_weapon_frag_grenade","mp_weapon_grenade_electric_smoke","mp_weapon_grenade_emp","mp_weapon_grenade_gravity","mp_weapon_grenade_sonar"]
const asset ChestModelClose = $"models/containers/pelican_case_large_imc.mdl" //pelican_case_large_imc OR pelican_case_large
const asset ChestModelOpen = $"models/containers/pelican_case_imc_open.mdl" // pelican_case_imc_open OR pelican_case_large_open
int NumChest = 20
const vector chestMainWeaponOffset = <(-3), -3, 30>
const vector chestMainWeaponAngle = <0, 30, 90>

bool ForceEndGame = false
bool BlockMessageFromDeathPlayer = true
int AtStartNumAlivePlayer = 0
int NumAlivePlayer = 0
int spawnPositionChoice = 0
array<int> spawnPositionAlreadyChoice = []
array<vector> ChestSpawnPoint
entity chest = null
entity playerChest = null
array< array< vector > > spawnChestList = []

void function GamemodeTBR_Init()
{
    #if SERVER
    ClassicMP_ForceDisableEpilogue( true )

    minPlayer = GetCurrentPlaylistVarInt("min_players", 2)

    TBRIntroLength = GetCurrentPlaylistVarFloat("BR_IntroLength", 0)
    spawnWithMainWeapon =  GetCurrentPlaylistVarInt("BR_SpawnWithMainWeapon", 0) == 1
    spawnWithSecondaryWeapon =  GetCurrentPlaylistVarInt("BR_SpawnWithSecondaryWeapon", 0) == 1
    spawnWithAntiTitanWeapon = GetCurrentPlaylistVarInt("BR_SpawnWithAntiTitanWeapon", 0) == 1

    spawnMainWeapon = GetCurrentPlaylistVarString("BR_SpawnMainWeapon", "") //empty for random weapon in mainWeapons
    spawnSecondaryWeapon = GetCurrentPlaylistVarString("BR_SpawnSecondaryWeapon", "") //"mp_weapon_autopistol" // empty for random weapon in secondaryWeapons
    spawnAntiTitanWeapon =  GetCurrentPlaylistVarString("BR_SpawnAntiTitanWeapon", "") // empty for random weapon in antiTitanWeapons

    NumChest = GetCurrentPlaylistVarInt("BR_NumChest", 20)

    //SetShouldUseRoundWinningKillReplay( true ) //Not sur it's working because Round Winning and I don't use round
    SetSpawnpointGamemodeOverride( FFA )
    SetLoadoutGracePeriodEnabled( false )
    SetWeaponDropsEnabled( true )
    SetRespawnsEnabled( false )

    AddCallback_OnReceivedSayTextMessage(ChatMessageFilter)

    if ( GetCurrentPlaylistVarInt( "BR_EnableDevMod", 0 ) == 1 ) {
        AddCallback_OnReceivedSayTextMessage(DevChatCommande)
    }
    if( GetCurrentPlaylistVarInt("BR_canSpawnTitan", 0) == 0) {
        Riff_ForceTitanAvailability( eTitanAvailability.Never )
    }
    if( GetCurrentPlaylistVarInt("BR_canUseBoost", 0) == 0) {
        Riff_ForceBoostAvailability( eBoostAvailability.Disabled )
    }

    PrecacheModel( ChestModelClose )
    PrecacheModel( ChestModelOpen )

    if(spawnMainWeapon == "" || spawnMainWeapon == "empty") {
        spawnMainWeapon = mainWeapons[ RandomInt( mainWeapons.len() ) ]
    }
    if(spawnSecondaryWeapon == "" || spawnSecondaryWeapon == "empty") {
        spawnSecondaryWeapon = secondaryWeapons[ RandomInt( secondaryWeapons.len() ) ]
    }
    if(spawnAntiTitanWeapon == "" || spawnAntiTitanWeapon == "empty") {
        spawnAntiTitanWeapon = antiTitanWeapons[ RandomInt( antiTitanWeapons.len() ) ]
    }

    ClassicMP_SetCustomIntro( TBRIntroSetup, TBRIntroLength )
    #endif
}

void function TBRIntroSetup()
{   
    AddCallback_GameStateEnter( eGameState.Prematch, TBRIntroStart )
    AddCallback_GameStateEnter( eGameState.Playing, TBRStartPlaying )
    AddCallback_OnClientConnected( TBROnClientConnect )
    AddCallback_OnClientDisconnected( TBROnClientDisconnect )
    AddCallback_OnPlayerKilled( OnPlayerKilled )
}

void function TBRIntroStart() {

    printt( "Prematch Start" )
    thread TBRIntroStartThreaded()
    foreach ( entity player in GetPlayerArray() ) {
        TBROnClientConnect( player )
    }
}

void function TBRIntroStartThreaded() {

	ClassicMP_OnIntroStarted()
	
    if(GetSpawnPointForChest().len() <= NumChest) {
        //throw "Map not compatible, using player spawn point for chest spawn point !!!!"
        Chat_ServerBroadcast("Map not compatible, using player spawn point for chest spawn point !!!!")
        array<entity> spawns = GetEntArrayByClass_Expensive( "info_spawnpoint_human" ) //info_spawnpoint_human_start
        for(int i = 0; i<NumChest;i++) {
            do {
                spawnPositionChoice = RandomInt(spawns.len())
            } while(spawnPositionAlreadyChoice.find(spawnPositionChoice) != -1)
            spawnPositionAlreadyChoice.push(spawnPositionChoice)
            chest = CreatePropDynamic(ChestModelClose, spawns[spawnPositionChoice].GetOrigin(), spawns[spawnPositionChoice].GetAngles()+<0,-90,0>, 6)
            chest.SetUsable()
            chest.Solid()
            AddCallback_OnUseEntity(chest, OnChestUsed)
        }
        spawnPositionAlreadyChoice = []
    } else {
        for(int i = 0; i<NumChest;i++) {
            do {
                spawnPositionChoice = RandomInt(GetSpawnPointForChest().len())
            } while(spawnPositionAlreadyChoice.find(spawnPositionChoice) != -1)
            spawnPositionAlreadyChoice.push(spawnPositionChoice)
            ChestSpawnPoint = GetSpawnPointForChest()[spawnPositionChoice]
            chest = CreatePropDynamic(ChestModelClose,ChestSpawnPoint[0], ChestSpawnPoint[1], 6)
            chest.SetUsable()
            chest.Solid()
            AddCallback_OnUseEntity(chest, OnChestUsed)
        }
    }

	wait TBRIntroLength

	ClassicMP_OnIntroFinished()

}

void function TBRStartPlaying() {
    printt( "Start Playing" )
    NumAlivePlayer = GetPlayerArray().len()
    if(GetPlayerArray().len() < minPlayer) {
        GameRules_ChangeMap(LobbyMaps[RandomInt(LobbyMaps.len())], GAMEMODE_TBR_LOBBY)
    }
    foreach ( entity player in GetPlayerArray() ) {
        if ( !IsPrivateMatchSpectator( player ) )
        {
            player.UnfreezeControlsOnServer()
            RemoveCinematicFlag( player, CE_FLAG_CLASSIC_MP_SPAWNING )
        }
        TryGameModeAnnouncement( player )
        
        NSCreateStatusMessageOnPlayer(player,NumAlivePlayer.tostring(),"#TBR_PlayerLeftPannelDesc", "TBR_PlayerLeftPannelID")

    }
}


void function TBROnClientConnect( entity player ) {
    if( GetGameState() == eGameState.Prematch ) {
        if(!IsPrivateMatchSpectator(player)) {
            thread TBR_Spawn_Player_Threaded( player )
        }
    }
	
}

void function TBROnClientDisconnect( entity player ) {
    if( GetGameState() == eGameState.Playing ) {
        if(IsAlive(player)) {
            NumAlivePlayer--
            foreach(entity player in GetPlayerArray()) {
                if(NumAlivePlayer <= 3 && NumAlivePlayer > 1) {
                    Remote_CallFunction_NonReplay( player, "GameNumPlayerLeftAnnouncement", NumAlivePlayer )
                }
                NSEditStatusMessageOnPlayer(player,NumAlivePlayer.tostring(),"#TBR_PlayerLeftPannelDesc", "TBR_PlayerLeftPannelID")
                if(NumAlivePlayer <= 1 && IsAlive(player)) {
                    SetWinner(player.GetTeam())
                }
            }
        }
    }
}

void function OnPlayerKilled(entity victim, entity attacker, var damageInfo) {
    if(GetGameState() == eGameState.Playing) {
        NumAlivePlayer--
        foreach(entity player in GetPlayerArray()) {
            if(NumAlivePlayer <= 3 && NumAlivePlayer > 1) {
                Remote_CallFunction_NonReplay( player, "GameNumPlayerLeftAnnouncement", NumAlivePlayer )
            }
            if(IsAlive(player)) {
                AddTeamScore( player.GetTeam(), 1 )
                player.AddToPlayerGameStat( PGS_ASSAULT_SCORE, 1 )
            }
            NSEditStatusMessageOnPlayer(player,NumAlivePlayer.tostring(),"#TBR_PlayerLeftPannelDesc", "TBR_PlayerLeftPannelID")
        }
        if(NumAlivePlayer <= 1) {
            SetWinner(attacker.GetTeam())
        }
    }
}

void function TBR_Spawn_Player_Threaded( entity player )
{   
    if(IsAlive(player)) {
        player.Die()
    }

    AddCinematicFlag( player, CE_FLAG_CLASSIC_MP_SPAWNING )
	ScreenFadeFromBlack( player, 0.5, 0.5 )
	
	if ( !IsValid( player ) ) // if player leaves during the intro sequence
		return
    RespawnAsPilot(player)
    GiveStartWeapon( player )
    player.FreezeControlsOnServer()
}

var function OnChestUsed(var ent, var player) {
    expect entity( ent )
    expect entity( player )
    if(ent.GetModelName() == ChestModelClose) {
        ent.SetModel(ChestModelOpen)
        entity weapon = CreateWeaponEntityByNameWithPhysics( mainWeapons[ RandomInt( mainWeapons.len() ) ], ent.GetOrigin()+chestMainWeaponOffset, ent.GetAngles()+chestMainWeaponAngle )
        weapon.SetVelocity( <0,0,0> )
    }
}

void function GiveStartWeapon(entity player)
{
    foreach ( entity weapon in player.GetMainWeapons() )
        player.TakeWeaponNow( weapon.GetWeaponClassName() )

    if(spawnWithMainWeapon) {
        player.GiveWeapon( spawnMainWeapon )
    }
    if(spawnWithSecondaryWeapon) {
        player.GiveWeapon( spawnSecondaryWeapon )
    }
    if(spawnWithAntiTitanWeapon) {
        player.GiveWeapon( spawnAntiTitanWeapon )
    }
}
// void Chat_PrivateMessage(entity fromPlayer, entity toPlayer, string text, bool whisper)
ClServer_MessageStruct function ChatMessageFilter(ClServer_MessageStruct message) {
    if(BlockMessageFromDeathPlayer && !IsAlive(message.player)) {
        message.shouldBlock = true
        foreach( entity player in GetPlayerArray()) {
            if(!IsAlive(player)) {
                Chat_PrivateMessage(message.player, player, message.message, false)
            }
        }
    }

    return message
}

// void Chat_ServerPrivateMessage(entity toPlayer, string text, bool whisper, bool withServerTag = true)
ClServer_MessageStruct function DevChatCommande(ClServer_MessageStruct message)
{   
    if (message.message.find("!feg") != null) {
        Chat_ServerBroadcast("Force End Game.")
        SetWinner(GetPlayerArray()[0].GetTeam())

    } else if(message.message.find("!ppos") != null) {
        Chat_ServerPrivateMessage(message.player, "Player Position : " + message.player.GetOrigin(), true, true)
        Chat_ServerPrivateMessage(message.player, "Player Angle : " + message.player.GetAngles()+<0,-90,0>, true, true)
    
    } else if(message.message.find("!spc") != null) {
        if(playerChest != null) {
            playerChest.Destroy()
        }
        playerChest = CreatePropDynamic(ChestModelClose,message.player.GetOrigin(), message.player.GetAngles()+<0,-90,0>)
        Chat_ServerPrivateMessage(message.player, "Player Position : " + message.player.GetOrigin(), true, true)
        Chat_ServerPrivateMessage(message.player, "Player Angle : " + (message.player.GetAngles()+<0,-90,0>), true, true)
        Chat_ServerPrivateMessage(message.player, "Code line : [" + playerChest.GetOrigin() + ", "+playerChest.GetAngles()+"],", true, true)
    
    } else if(message.message.find("!vpc") != null) {
        if(spawnChestList == []) {
            spawnChestList = GetSpawnPointForChest()
        }
        spawnChestList.push([playerChest.GetOrigin(),playerChest.GetAngles()])
        print(spawnChestList)

    
    } else if(message.message.find("!cfs") != null) {
        for(int i = 0; i < GetSpawnPointForChest().len(); i++){
            if(spawnPositionAlreadyChoice.find(i) == -1) {
                spawnPositionAlreadyChoice.push(i)
                ChestSpawnPoint = GetSpawnPointForChest()[i]
                chest = CreatePropDynamic(ChestModelClose,ChestSpawnPoint[0], ChestSpawnPoint[1], 6)
                chest.SetUsable()
                chest.Solid()
                AddCallback_OnUseEntity(chest, OnChestUsed)
            }
        }
    
    } else if(message.message.find("!spawn") != null) {
        if(message.message.find("weapon")) {
            if(message.message.find("*") != null) {
                foreach(string weapon in mainWeapons)
                CreateWeaponEntityByNameWithPhysics( weapon, message.player.GetOrigin(), message.player.GetAngles() )
            } else {
                foreach(string weapon in mainWeapons) {
                    if(message.message.find(weapon) != null) {
                        CreateWeaponEntityByNameWithPhysics( weapon, message.player.GetOrigin(), message.player.GetAngles() )
                        Chat_ServerPrivateMessage(message.player, "Weapon : " + weapon + " spawned !", true, true)
                    }
                }
                foreach(string weapon in secondaryWeapons) {
                    if(message.message.find(weapon) != null) {
                        CreateWeaponEntityByNameWithPhysics( weapon, message.player.GetOrigin(), message.player.GetAngles() )
                        Chat_ServerPrivateMessage(message.player, "Weapon : " + weapon + " spawned !", true, true)
                    }
                }
                foreach(string weapon in antiTitanWeapons) {
                    if(message.message.find(weapon) != null) {
                        CreateWeaponEntityByNameWithPhysics( weapon, message.player.GetOrigin(), message.player.GetAngles() )
                        Chat_ServerPrivateMessage(message.player, "Weapon : " + weapon + " spawned !", true, true)
                    }
                }
                foreach(string weapon in boostObject) {
                    if(message.message.find(weapon) != null) {
                        CreateWeaponEntityByNameWithPhysics( weapon, message.player.GetOrigin(), message.player.GetAngles() )
                        Chat_ServerPrivateMessage(message.player, "Weapon : " + weapon + " spawned !", true, true)
                    }
                }
            }
        }
    }

    return message
}





void function GamemodeTBR_Lobby_Init()
{   
    SetSpawnpointGamemodeOverride( FFA )
	ClassicMP_ForceDisableEpilogue( true )
	SetLoadoutGracePeriodEnabled( true )
	SetWeaponDropsEnabled( true )
	Riff_ForceTitanAvailability( eTitanAvailability.Never )

    minPlayer = GetCurrentPlaylistVarInt("min_players", 2)

    AddCallback_OnClientConnected( TBR_LOBBY_OnClientConnect )
}

void function TBR_LOBBY_OnClientConnect( entity player ) {
    NSCreateStatusMessageOnPlayer(player,"["+GetPlayerArray().len().tostring()+"/"+minPlayer+"]","#TBR_ConnectedPlayerDesc", "TBR_ConnectedPlayerID")
    
    foreach(entity player in GetPlayerArray()) {
        NSEditStatusMessageOnPlayer(player,"["+GetPlayerArray().len().tostring()+"/"+minPlayer+"]","#TBR_ConnectedPlayerDesc", "TBR_ConnectedPlayerID")
    }
    if(GetPlayerArray().len() >= minPlayer) {
        thread EnoughtPlayerToStart()
    }
}

void function EnoughtPlayerToStart() {
    float WaitingVoteTime = GetCurrentPlaylistVarFloat("WaitingVoteTime", 30.0)
    foreach(entity player in GetPlayerArray()) {
        Remote_CallFunction_NonReplay(player, "Cl_EnoughPlayerToStart", WaitingVoteTime)
    }
    CreateMapVotePoll(BRMaps, WaitingVoteTime)
    float endTime = Time() + WaitingVoteTime
    while( endTime > Time() ) {
        foreach(entity player in GetPlayerArray()){
            if(WaitingVoteTime == 20 || WaitingVoteTime == 15 || WaitingVoteTime <= 10) {
                Remote_CallFunction_NonReplay(player, "Cl_OnWaitingVote", WaitingVoteTime)
            }
            WaitingVoteTime--
        }
        wait 1
    }

    GameRules_ChangeMap(BRMaps[GetMapVoteWinner()], GAMEMODE_TBR)
}

void function CreateMapVotePoll(array<string> options, float time = 30) {
    foreach(entity player in GetPlayerArray())
        NSCreatePollOnPlayer(player, "#TBR_MapVoteTitle", options, time)
}

int function GetMapVoteWinner() {

    array<int> MapVoteResult = [0,0,0,0,0,0,0,0,0]
    int IndexWithTheBigestValue = 0
    int TheBigestValue = -1
    foreach(entity player in GetPlayerArray()) {
        if(NSGetPlayerResponse(player) != -1) {
            MapVoteResult[NSGetPlayerResponse(player)] = MapVoteResult[NSGetPlayerResponse(player)]+1
        }
    }

    //printt(MapVoteResult)

    foreach (int index, int val in MapVoteResult) {
        if(val > TheBigestValue) {
            TheBigestValue = val
            IndexWithTheBigestValue = index
        }
    }

    return IndexWithTheBigestValue //return the index of the map in the used array

}
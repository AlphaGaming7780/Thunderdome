global function GamemodeBR_SOLO_Init
global function GamemodeBR_LOBBY_Init


string spawnMainWeapon = ""
string spawnSecondaryWeapon = ""
string spawnAntiTitanWeapon = ""

const array<string> BRMaps = [ "mp_forwardbase_kodai",
    "mp_grave",
    "mp_homestead",
    "mp_thaw",
    //"mp_black_water_canal", //
    //"mp_eden", //
    //"mp_drydock", //
    //"mp_crashsite3", //
    "mp_complex3",
    "mp_angel_city",
    "mp_colony02",
    //"mp_glitch", //
    //"mp_lf_stacks", 
    //"mp_lf_deck",
    //"mp_lf_meadow",
    //"mp_lf_traffic",
    //"mp_lf_township",
    //"mp_lf_uma",
    //"mp_relic02",//
    "mp_wargames",
    //"mp_rise",//
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
const array<vector> chestMainWeaponOffset = [<(25), 25, 30>, <(-0), -0, 30>, <(-25), -25, 30>] // x == y !!!!
const vector chestMainWeaponAngle = <0, -30, 90> //<0, 30, 90> 

bool ForceEndGame = false
bool BlockMessageFromDeathPlayer = true
// int GetPlayerArray_Alive().len() = 0
int spawnPositionChoice = 0
array<int> spawnPositionAlreadyChoice = []
array<vector> ChestSpawnPoint
entity chest = null
entity playerChest = null
array< array< vector > > spawnChestList = []

void function GamemodeBR_SOLO_Init()
{
    #if SERVER
    ClassicMP_ForceDisableEpilogue( true )

    //SetShouldUseRoundWinningKillReplay( true ) //Not sur it's working because Round Winning and I don't use round
    SetSpawnpointGamemodeOverride( FFA )
    SetLoadoutGracePeriodEnabled( false )
    SetWeaponDropsEnabled( true )
    SetRespawnsEnabled( false )

    AddCallback_OnReceivedSayTextMessage(ChatMessageFilter)

    if ( GetConVarBool( "TBR_EnableDevMod" ) ) {
        AddCallback_OnReceivedSayTextMessage(DevChatCommande)
    }
    if( GetCurrentPlaylistVarInt("BR_canSpawnTitan", 0) == 0 ) { //!GetConVarBool( "BR_canSpawnTitan" )
        Riff_ForceTitanAvailability( eTitanAvailability.Never )
    }
    if( GetCurrentPlaylistVarInt("BR_canUseBoost", 0) == 0 ) { //!GetConVarBool( "BR_canUseBoost" )
        Riff_ForceBoostAvailability( eBoostAvailability.Disabled )
    }

    PrecacheModel( ChestModelClose )
    PrecacheModel( ChestModelOpen )

    if( GetCurrentPlaylistVarString("BR_SpawnMainWeapon", "empty" ) == "empty" ) { //GetConVarString("BR_SpawnMainWeapon")
        spawnMainWeapon = mainWeapons[ RandomInt( mainWeapons.len() ) ]
    } else {
        spawnMainWeapon = GetCurrentPlaylistVarString("BR_SpawnMainWeapon", "mp_weapon_car" ) //GetConVarString("BR_SpawnMainWeapon")
    }
    if( GetCurrentPlaylistVarString("BR_SpawnSecondaryWeapon", "empty" ) == "empty" ) { //GetConVarString("BR_SpawnSecondaryWeapon") == ""
        spawnSecondaryWeapon = secondaryWeapons[ RandomInt( secondaryWeapons.len() ) ]
    } else {
        spawnSecondaryWeapon = GetCurrentPlaylistVarString("BR_SpawnSecondaryWeapon", "mp_weapon_wingman" )  //GetConVarString("BR_SpawnSecondaryWeapon")
    }
    if(GetCurrentPlaylistVarString("BR_SpawnAntiTitanWeapon", "empty" ) == "empty") { //GetConVarString("BR_SpawnAntiTitanWeapon") == ""
        spawnAntiTitanWeapon = antiTitanWeapons[ RandomInt( antiTitanWeapons.len() ) ]
    } else {
        spawnAntiTitanWeapon =  GetCurrentPlaylistVarString("BR_SpawnAntiTitanWeapon", "mp_weapon_rocket_launcher" ) //GetConVarString("BR_SpawnAntiTitanWeapon")
    }

    ClassicMP_SetCustomIntro( BRIntroSetup, GetCurrentPlaylistVarFloat("BR_IntroLength", 10) ) //GetConVarInt("BR_IntroLength")
    #endif
}

void function BRIntroSetup()
{   
    AddCallback_GameStateEnter( eGameState.Prematch, BRIntroStart )
    AddCallback_GameStateEnter( eGameState.Playing, BRStartPlaying )
    AddCallback_OnClientConnected( BROnClientConnect )
    AddCallback_OnClientDisconnected( BROnClientDisconnect )
    AddCallback_OnPlayerKilled( OnPlayerKilled )
}

void function BRIntroStart() {

    printt( "Prematch Start" )
    thread BRIntroStartThreaded()
    foreach ( entity player in GetPlayerArray() ) {
        BROnClientConnect( player )
    }
}

void function BRIntroStartThreaded() {

	ClassicMP_OnIntroStarted()

	wait GetCurrentPlaylistVarFloat("BR_IntroLength", 10) //GetConVarFloat("BR_IntroLength")

    if(GetSpawnPointForChest().len() <= GetCurrentPlaylistVarInt("BR_MinNumChest", 20)) { //GetConVarInt("BR_MinNumChest")
        //throw "Map not compatible, using player spawn point for chest spawn point !!!!"
        Chat_ServerBroadcast("Map : "+ GetMapName() +" not compatible, using player spawn point for chest spawn point !!!!")
        array<entity> spawns = GetEntArrayByClass_Expensive( "info_spawnpoint_human" ) //info_spawnpoint_human_start
        for(int i = 0; i < GetCurrentPlaylistVarInt("BR_MinNumChest", 20); i++) { //GetConVarInt("BR_MinNumChest")
            do {
                spawnPositionChoice = RandomInt(spawns.len())
            } while(spawnPositionAlreadyChoice.find(spawnPositionChoice) != -1)
            spawnPositionAlreadyChoice.push(spawnPositionChoice)
            chest = CreatePropDynamicLightweight(ChestModelClose, spawns[spawnPositionChoice].GetOrigin(), spawns[spawnPositionChoice].GetAngles()+<0,-90,0>, 6)
            chest.SetUsable()
            chest.Solid()
            AddCallback_OnUseEntity(chest, OnChestUsed)
        }
        spawnPositionAlreadyChoice = []
    } else {
        for(int i = 0; i < ( (GetPlayerArray().len() * GetCurrentPlaylistVarInt("BR_ChestMultPlayer", 2) > GetCurrentPlaylistVarInt("BR_MinNumChest", 20) ? GetPlayerArray().len() * GetCurrentPlaylistVarInt("BR_ChestMultPlayer", 2) : GetCurrentPlaylistVarInt("BR_MinNumChest", 20)) > GetSpawnPointForChest().len() ? GetSpawnPointForChest().len() : (GetPlayerArray().len() * GetCurrentPlaylistVarInt("BR_ChestMultPlayer", 2) > GetCurrentPlaylistVarInt("BR_MinNumChest", 20) ? GetPlayerArray().len() * GetCurrentPlaylistVarInt("BR_ChestMultPlayer", 2) : GetCurrentPlaylistVarInt("BR_MinNumChest", 20)) ); i++) { //GetConVarInt("BR_MinNumChest")s
            do {
                spawnPositionChoice = RandomInt(GetSpawnPointForChest().len())
            } while(spawnPositionAlreadyChoice.find(spawnPositionChoice) != -1)
            spawnPositionAlreadyChoice.push(spawnPositionChoice)
            ChestSpawnPoint = GetSpawnPointForChest()[spawnPositionChoice]
            chest = CreatePropDynamicLightweight(ChestModelClose,ChestSpawnPoint[0], ChestSpawnPoint[1], 6)
            chest.SetUsable()
            chest.Solid()
            AddCallback_OnUseEntity(chest, OnChestUsed)
        }
    }

	ClassicMP_OnIntroFinished()

}

void function BRStartPlaying() {
    printt( "Start Playing" )
    if(GetPlayerArray_Alive().len() < GetConVarInt("TBR_min_players") ) {
        GameRules_ChangeMap(LobbyMaps[RandomInt(LobbyMaps.len())], GAMEMODE_BR_LOBBY)
    }
    foreach ( entity player in GetPlayerArray() ) {
        player.UnfreezeControlsOnServer()
        RemoveCinematicFlag( player, CE_FLAG_CLASSIC_MP_SPAWNING )
        TryGameModeAnnouncement( player )

        if( GetCurrentPlaylistVarInt("BR_MinPlayerForHighlight", 2) >= GetPlayerArray_Alive().len()) { //GetConVarInt("BR_MinPlayerForHighlight")
            Highlight_SetEnemyHighlight( player, "battery_thief" ) //enemy_sonar | enemy_player | sp_enemy_pilot | battery_thief
        }
        
        NSCreateStatusMessageOnPlayer(player,GetPlayerArray_Alive().len().tostring(),"#BR_SOLO_PlayerLeftPannelDesc", "BR_SOLO_PlayerLeftPannelID")

    }
}


void function BROnClientConnect( entity player ) {
    if( GetGameState() == eGameState.Prematch ) {
        thread BR_Spawn_Player_Threaded( player )
    }
	
}

void function BROnClientDisconnect( entity player ) {
    if( GetGameState() == eGameState.Playing ) {
        if(IsAlive(player)) {
            //GetPlayerArray_Alive().len()--
            foreach(entity player in GetPlayerArray()) {
                if(GetPlayerArray_Alive().len() <= 3 && GetPlayerArray_Alive().len() > 1) {
                    Remote_CallFunction_NonReplay( player, "GameNumPlayerLeftAnnouncement", GetPlayerArray_Alive().len() )
                }
                NSEditStatusMessageOnPlayer(player,GetPlayerArray_Alive().len().tostring(),"#BR_SOLO_PlayerLeftPannelDesc", "BR_SOLO_PlayerLeftPannelID")
                if(GetPlayerArray_Alive().len() <= 1 && IsAlive(player)) {
                    SetWinner(player.GetTeam())
                }
                if( GetCurrentPlaylistVarInt("BR_MinPlayerForHighlight", 2) >= GetPlayerArray_Alive().len()) { //GetConVarInt("BR_MinPlayerForHighlight")
                    Highlight_SetEnemyHighlight( player, "battery_thief" ) 
                }
            }
        }
    }
}

void function OnPlayerKilled(entity victim, entity attacker, var damageInfo) {
    if(GetGameState() == eGameState.Playing) {
        foreach(entity player in GetPlayerArray()) {
            if(GetPlayerArray_Alive().len() <= 3 && GetPlayerArray_Alive().len() > 1) {
                Remote_CallFunction_NonReplay( player, "GameNumPlayerLeftAnnouncement", GetPlayerArray_Alive().len() )
            }
            if(IsAlive(player)) {
                AddTeamScore( player.GetTeam(), 1 )
                player.AddToPlayerGameStat( PGS_ASSAULT_SCORE, 1 )
                if( GetCurrentPlaylistVarInt("BR_MinPlayerForHighlight", 2) >= GetPlayerArray_Alive().len()) { //GetConVarInt("BR_MinPlayerForHighlight")
                    Highlight_SetEnemyHighlight( player, "battery_thief" ) 
                }
            }
            NSEditStatusMessageOnPlayer(player,GetPlayerArray_Alive().len().tostring(),"#BR_SOLO_PlayerLeftPannelDesc", "BR_SOLO_PlayerLeftPannelID")
        }

        if(GetPlayerArray_Alive().len() <= 1) {
            SetWinner(attacker.GetTeam())
        }

    }
}

void function BR_Spawn_Player_Threaded( entity player )
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
    if(GetCurrentPlaylistVarInt( "BR_EnableDevMod", 0 ) == 1) {
        printt(ent.GetOrigin())
    }
    if(ent.GetModelName() == ChestModelClose) {
        ent.SetModel(ChestModelOpen)
        entity weapon
        for(int i = 0; i < GetCurrentPlaylistVarInt("BR_NumWeaponInChest", 2); i++) {
            int weapontype = RandomInt(3)
            if(weapontype == 0 && GetCurrentPlaylistVarInt("BR_SpawnMainWeaponInChest", 1) == 1 ) {
                weapon = CreateWeaponEntityByNameWithPhysics( mainWeapons[ RandomInt( mainWeapons.len() ) ], ent.GetOrigin()+<chestMainWeaponOffset[i].x * deg_cos(ent.GetAngles().y) -10 * deg_sin(ent.GetAngles().y), chestMainWeaponOffset[i].y * deg_sin(ent.GetAngles().y) +10 * deg_cos(ent.GetAngles().y), chestMainWeaponOffset[i].z>, ent.GetAngles()+chestMainWeaponAngle ) //

            } else if ( weapontype == 1 && GetCurrentPlaylistVarInt("BR_SpawnSecondaryWeaponInChest", 1) == 1 ) {
                weapon = CreateWeaponEntityByNameWithPhysics( secondaryWeapons[ RandomInt( secondaryWeapons.len() ) ], ent.GetOrigin()+<chestMainWeaponOffset[i].x * deg_cos(ent.GetAngles().y) -10 * deg_sin(ent.GetAngles().y), chestMainWeaponOffset[i].y * deg_sin(ent.GetAngles().y) +10 * deg_cos(ent.GetAngles().y), chestMainWeaponOffset[i].z>, ent.GetAngles()+chestMainWeaponAngle ) //+chestMainWeaponOffset[i]

            } else if( weapontype == 2 && GetCurrentPlaylistVarInt("BR_SpawnAntiTitanWeaponInChest", 0) == 1) {
                weapon = CreateWeaponEntityByNameWithPhysics( antiTitanWeapons[ RandomInt( antiTitanWeapons.len() ) ], ent.GetOrigin()+<chestMainWeaponOffset[i].x * deg_cos(ent.GetAngles().y) -10 * deg_sin(ent.GetAngles().y), chestMainWeaponOffset[i].y * deg_sin(ent.GetAngles().y) +10 * deg_cos(ent.GetAngles().y), chestMainWeaponOffset[i].z>, ent.GetAngles()+chestMainWeaponAngle ) //+chestMainWeaponOffset[i]
            } else {
                i--
                continue
            }
            weapon.SetVelocity( <0,0,0> )
            weapon.SetParent(ent)

            Remote_CallFunction_NonReplay( player, "Cl_CreateLight", weapon.GetOrigin().x, weapon.GetOrigin().y, weapon.GetOrigin().z)
        }
        //Remote_CallFunction_NonReplay( player, "Cl_CreateLight", weapon.GetOrigin().x, weapon.GetOrigin().y, weapon.GetOrigin().z)
    } else if(ent.GetModelName() == ChestModelOpen) {
        for(int i = 0; i < GetCurrentPlaylistVarInt("BR_NumWeaponInChest", 2); i++) {
            Remote_CallFunction_NonReplay( player, "Cl_CreateLight", ent.GetOrigin().x+chestMainWeaponOffset[i].x * deg_cos(ent.GetAngles().y) -10 * deg_sin(ent.GetAngles().y), ent.GetOrigin().y + chestMainWeaponOffset[i].y * deg_sin(ent.GetAngles().y) +10 * deg_cos(ent.GetAngles().y), ent.GetOrigin().z + chestMainWeaponOffset[i].z)
        }
    }
}

void function GiveStartWeapon(entity player)
{
    foreach ( entity weapon in player.GetMainWeapons() )
        player.TakeWeaponNow( weapon.GetWeaponClassName() )

    if(GetCurrentPlaylistVarInt("BR_SpawnWithMainWeapon", 0) == 1) {
        player.GiveWeapon( spawnMainWeapon )
    }
    if(GetCurrentPlaylistVarInt("BR_SpawnWithSecondaryWeapon", 1) == 1) {
        player.GiveWeapon( spawnSecondaryWeapon )
    }
    if(GetCurrentPlaylistVarInt("BR_SpawnWithAntiTitanWeapon", 0) == 1) {
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
        playerChest = CreatePropDynamicLightweight(ChestModelClose,message.player.GetOrigin(), message.player.GetAngles()+<0,-90,0>)
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
                chest = CreatePropDynamicLightweight(ChestModelClose,ChestSpawnPoint[0], ChestSpawnPoint[1], 6)
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
    } else if( message.message.find("!cltest") != null) {
        Remote_CallFunction_NonReplay( message.player ,"Cl_TEST")
    } else if( message.message.find("!gpt") != null) {
        Chat_ServerBroadcast( message.player + " Team :" + message.player.GetTeam().tostring())
    }

    return message
}





void function GamemodeBR_LOBBY_Init()
{   
    SetSpawnpointGamemodeOverride( FFA )
	ClassicMP_ForceDisableEpilogue( true )
	SetLoadoutGracePeriodEnabled( true )
	SetWeaponDropsEnabled( true )
	Riff_ForceTitanAvailability( eTitanAvailability.Never )

    AddCallback_OnClientConnected( BR_LOBBY_OnClientConnect )
}

void function BR_LOBBY_OnClientConnect( entity player ) {
    NSCreateStatusMessageOnPlayer(player,"["+GetPlayerArray().len().tostring()+"/"+GetConVarInt("TBR_min_players")+"]","#BR_LOBBY_ConnectedPlayerDesc", "BR_LOBBY_ConnectedPlayerID")
    
    foreach(entity player in GetPlayerArray()) {
        NSEditStatusMessageOnPlayer(player,"["+GetPlayerArray().len().tostring()+"/"+GetConVarInt("TBR_min_players")+"]","#BR_LOBBY_ConnectedPlayerDesc", "BR_LOBBY_ConnectedPlayerID")
    }
    if(GetPlayerArray().len() >= GetConVarInt("TBR_min_players")) {
        thread EnoughtPlayerToStart()
    }
}

void function EnoughtPlayerToStart() {
    float WaitingVoteTime = GetCurrentPlaylistVarFloat("BR_LOBBY_WaitingVoteTime", 30)
    array<int> MapVoteAlreadyChoice = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    array<string> MapVote
    array<string> MapVoteLocalised
    foreach(entity player in GetPlayerArray()) {
        Remote_CallFunction_NonReplay(player, "Cl_EnoughPlayerToStart", WaitingVoteTime)
    }
    if(BRMaps.len() > 9) {
        for(int i = 0; i < 9; i++) {
            do {
                MapVoteAlreadyChoice[i] = RandomIntRange(0,BRMaps.len()-1)
            } while(MapVoteAlreadyChoice.find(MapVoteAlreadyChoice[i]) != i)
            MapVote.push(BRMaps[MapVoteAlreadyChoice[i]])
            MapVoteLocalised.push("#"+BRMaps[MapVoteAlreadyChoice[i]])
        }
    } else {
        for(int i = 0; i < BRMaps.len(); i++) {
            MapVote.push(BRMaps[i])
            MapVoteLocalised.push("#"+BRMaps[i])
        }
    }

    CreateMapVotePoll(MapVoteLocalised, WaitingVoteTime)
    float endTime = Time() + WaitingVoteTime
    while( endTime > Time() ) {
        foreach(entity player in GetPlayerArray()){
            if(WaitingVoteTime == 20 || WaitingVoteTime == 15 || WaitingVoteTime <= 10) {
                Remote_CallFunction_NonReplay(player, "Cl_OnWaitingVote", WaitingVoteTime)
            }
        }
        WaitingVoteTime--
        wait 1
    }

    GameRules_ChangeMap(MapVote[GetMapVoteWinner()], GAMEMODE_BR_SOLO)
}

void function CreateMapVotePoll(array<string> options, float time = 30) {
    foreach(entity player in GetPlayerArray())
        NSCreatePollOnPlayer(player, "#BR_MapVoteTitle", options, time)
}

int function GetMapVoteWinner() {

    array<int> MapVoteResult = [0, 0, 0, 0, 0, 0, 0, 0, 0]
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
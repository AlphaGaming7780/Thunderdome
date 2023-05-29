
# Thunderdome

Thunderdome is a mod for Northstar (Titanfall 2), this mod add a new game mode: Battle Royale.

Players will join a lobby and once the minimum required number of players has been reached, a vote for the map (of the Battle Royale or the game mode you create) will take place. Once this vote has ended, the Battle Royale game (or the game mode you create) will begin. The lobby is a classic FFA mod.

The mod has great [customization](https://github.com/AlphaGaming7780/Thunderdome#documentation) possibilities by modifying the [ConVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#convars) and the [PlaylitsVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides) of the game mode, for example, you can disable chest spawn, enable random weapon donation at spawn and end up with a FFADM (Free For All Death Match, I don't know how to call this).

You can see the changelog [here](https://github.com/AlphaGaming7780/Thunderdome/blob/main/Changelog.md)

### **This mod is required on both the client and server sides.**


## Documentation
It is possible to customize the game mode with the [ConVars](https://github.com/AlphaGaming7780/Thunderdome#convars) and [PlaylitsVars](https://github.com/AlphaGaming7780/Thunderdome#playlistvar) of the mod, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server)

if the **ConVars** start with `TD_`, it mean that variable are used in both lobby and Battle Royale game mode.

If the **PlaylistVar** start with `TD_`, it mean that variable are only used for the Battle Royale game mode except the Lobby,

if the **PlaylistVar** start with `TD_LOBBY_`, it mean that variable are only used for the Lobby Battle Royale game mode,

and if they start with nothing before, it mean that variable are used for both game mode.

### ConVars
| ConVars | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `TD_min_players` | `Int` | `2` | In Lobby game mode is the minimum player needed to start a game, in the main game mode, is the min player needed to stop the game and return the player to the lobby. |
|`TD_EnableDevMod` | `Bool (Int)` | `0` | Enable the DEV mode |

### PlaylistVar

You can use the following command line as startup arguments to edit the PlaylistVar or direclly edit [PlayLits_v2.txt](https://github.com/AlphaGaming7780/Thunderdome/blob/main/keyvalues/playlists_v2.txt) file.
```
+setplaylistvaroverrides "max_players 10 max_teams 10 TD_MinNumChest 40 TTD_SpawnWithMainWeapon 1 TTD_SpawnMainWeapon mp_weapon_car"
```

| PlaylistVar | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server, **need to be the same value for both game mode.** |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`, you can have 20 team max, game limite, so 20 player max, **need to be the same value for both game mode.**|
| `TD_EnableSpectating` | `Bool (Int)` | `1` | Allowed death player to spectate other player, `0` : False, `1` : True |
| `TD_BlockMessageFromDeathPlayer` | `Bool (Int)` | `1` | Messages from dead players are hidden from live players, but other dead players can still view them, `0` : False, `1` : True |
| `TD_CanSpawnTitan` | `Bool (Int)` | `0` | Allowed player to summon their titan, `0` : False, `1` : True |
| `TD_CanUseBoost` | `Bool (Int)` | `0` | Allowed player to use their boost, `0` : False, `1` : True |
| `TD_ReplaceWeapon` | `Bool (Int)` | `1` | Replace player weapons at the start of the game, `0` : False, `1` : True |
<!-- | `TD_MaxWeapon` | `Int` | `2` | Max number of weapon a player can take | -->
| `TD_IntroLength` | `Float` | `10` | Time of the prematch state in seconde |
| `TD_SpawnChest` | `Bool  (Int)` | `1` | Spawn chest arround the map, `0` : False, `1` : True |
| `TD_ChestMultPlayer` | `Int` | `2` | ```(TD_ChestMultPlayer * NumPlayer) > TD_MinNumChest ? TD_ChestMultPlayer * NumPlayer : TD_MinNumChest``` |
| `TD_MinNumChest` | `Int` | `20` | The numbres of chest that spawn in the map |
| `TD_NumWeaponInChest` | `Int` | `3` | The numbres of weapon that spawn in the chest, **max 3** |
| `TD_SpawnMainWeaponInChest` | `Bool  (Int)` | `1` | Can main weapon spawn in chest |
| `TD_SpawnSecondaryWeaponInChest` | `Bool  (Int)` | `1` | Can secondary weapon spawn in chest |
| `TD_SpawnAntiTitanWeaponInChest` | `Bool  (Int)` | `0` | Can anti titan weapon spawn in chest |
| `TD_SpawnWithMainWeapon` | `Bool  (Int)` | `0` | If the player spawn with a main weapon, `0` : False, `1` : True |
| `TD_SpawnWithSecondaryWeapon` | `Bool  (Int)` | `1` | If the player spawn with a secondary weapon, `0` : False, `1` : True |
| `TD_SpawnWithAntiTitanWeapon` | `Bool  (Int)` | `0` | If the player spawn with a anti titan weapon, `0` : False, `1` : True |
| `TD_SpawnMainWeapon` | `String` | `empty` | The main weapon the player will spawn with, `"empty"` = random weapon |
| `TD_SpawnSecondaryWeapon` | `String` | `mp_weapon_semipistol` | The secondary weapon the player will spawn whit, `"empty"` = random weapon |
| `TD_SpawnAntiTitanWeapon` | `String` | `empty` | The anti titan weapon the player will spawn whit, `"empty"` = random weapon |
| `TD_MinPlayerForHighlight` | `Int` | `2` | The minimum number of players alive to high light the remaining players |
| `TD_LOBBY_WaitingVoteTime` | `Float` | `30` | The time the server wait for player to vote for the next map, before it load the map the player vote. |

## Special Thanks

### For answering my questions on the [Northstar discord](https://discord.gg/northstar)

    - Spoon#1812
    - uniboi#5786
    - Neinguar / NoCatt (NoCatt#8128)
    - [UK]The peepeepoopoo man (The peepeepoopoo man#3301)
    - BobTheBob#1150
    - Nine+Ten (Fifty#8113)

### For translations
| Languag | Contributor |
| ------- | ----------- |
| English | ChatGPT |
| French | ᚖ 𝔸𝕝𝕡𝕙𝕒 𝔾𝕒𝕞𝕚𝕟𝕘 ᚖ#5720 (ME) |
| German | ChatGPT |
| Italian | ChatGPT |
| Japanese | ChatGPT |
| Portuguese| Dartzinho_V#8820 |
| Russian | spoon#0407 |
| Spanish | ChatGPT |
| Traditional Chinese | zxcPandora#1581 |

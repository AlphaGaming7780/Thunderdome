
# Thunderdome

Thunderdome is a mod for Northstar (Titanfall 2), this mod add a new game mode: Battle Royale.

Players will join a lobby and once the minimum required number of players has been reached, a vote for the map (of the Battle Royale) will take place. Once this vote has ended, the Battle Royale game will begin. The lobby is a classic FFA mod.

The mod has great [customization](https://github.com/AlphaGaming7780/Thunderdome#documentation) possibilities by modifying the [ConVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#convars) and the [PlaylitsVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides) of the game mode, for example, you can disable chest spawn, enable random weapon donation at spawn and end up with a FFADM (Free For All Death Match).

You can see the changelog [here](https://github.com/AlphaGaming7780/Thunderdome/blob/main/Changelog.md)

### **This mod is required on both the client and server sides.**


## Documentation
It is possible to customize the game mode with the [ConVars](https://github.com/AlphaGaming7780/Thunderdome#convars) and [PlaylitsVars](https://github.com/AlphaGaming7780/Thunderdome#playlistvar) of the mod, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server)

if the ConVars start with `TBR_`, it mean that variable are used in both lobby and Battle Royale game mode.

If the PlaylistVar start with `BR_`, it mean that variable are only used for the Battle Royale game mode except the Lobby,

if the PlaylistVar start with `BR_LOBBY_`, it mean that variable are only used for the Lobby Battle Royale game mode,

and if they start with nothing before, it mean that variable are used for both game mode.

### ConVars
| ConVars | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `TBR_min_players` | `Int` | `2` | In Lobby game mode is the minimum player needed to start a game, in Batlle Royale game mode the min player needed to stop the game and return the player to the lobby. |
|`TBR_EnableDevMod` | `Bool (Int)` | `0` | Enable the DEV mode |

### PlaylistVar

You can use the following command line as startup arguments to edit the PlaylistVar or direclly edit [PlayLits_v2.txt](https://github.com/AlphaGaming7780/Thunderdome/blob/main/keyvalues/playlists_v2.txt) file.
```
+setplaylistvaroverrides "max_players 10 max_teams 10 BR_MinNumChest 40 TBR_SpawnWithMainWeapon 1 TBR_SpawnMainWeapon mp_weapon_car"
```

| PlaylistVar | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server, **need to be the same value for both game mode.** |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`, you can have 20 team max, game limite, so 20 player max, **need to be the same value for both game mode.**|
| `BR_canSpawnTitan` | `Bool (Int)` | `0` | Allowed player to summon their titan, `0` : False, `1` : True |
| `BR_canUseBoost` | `Bool (Int)` | `0` | Allowed player to use their boost, `0` : False, `1` : True |
| `BR_MaxWeapon` | `Int` | `2` | Max number of weapon a player can take |
| `BR_IntroLength` | `Float` | `10` | Time of the prematch state in seconde |
| `BR_ChestMultPlayer` | `Int` | `2` | ```(BR_ChestMultPlayer * NumPlayer) > BR_MinNumChest ? BR_ChestMultPlayer * NumPlayer : BR_MinNumChest``` |
| `BR_MinNumChest` | `Int` | `20` | The numbres of chest that spawn in the map |
| `BR_NumWeaponInChest` | `Int` | `3` | The numbres of weapon that spawn in the chest |
| `BR_SpawnMainWeaponInChest` | `Bool  (Int)` | `1` | Can main weapon spawn in chest |
| `BR_SpawnSecondaryWeaponInChest` | `Bool  (Int)` | `1` | Can secondary weapon spawn in chest |
| `BR_SpawnAntiTitanWeaponInChest` | `Bool  (Int)` | `0` | Can anti titan weapon spawn in chest |
| `BR_SpawnWithMainWeapon` | `Bool  (Int)` | `0` | If the player spawn with a main weapon, `0` : False, `1` : True |
| `BR_SpawnWithSecondaryWeapon` | `Bool  (Int)` | `1` | If the player spawn with a secondary weapon, `0` : False, `1` : True |
| `BR_SpawnWithAntiTitanWeapon` | `Bool  (Int)` | `0` | If the player spawn with a anti titan weapon, `0` : False, `1` : True |
| `BR_SpawnMainWeapon` | `String` | `empty` | The main weapon the player will spawn with, `"empty"` = random weapon |
| `BR_SpawnSecondaryWeapon` | `String` | `mp_weapon_semipistol` | The secondary weapon the player will spawn whit, `"empty"` = random weapon |
| `BR_SpawnAntiTitanWeapon` | `String` | `empty` | The anti titan weapon the player will spawn whit, `"empty"` = random weapon |
| `BR_MinPlayerForHighlight` | `Int` | `2` | The minimum number of players alive to high light the remaining players |
| `BR_LOBBY_WaitingVoteTime` | `Float` | `30` | The time the server wait for player to vote for the next map, before it load the map the player vote. |

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
| English |  |
| French | ᚖ 𝔸𝕝𝕡𝕙𝕒 𝔾𝕒𝕞𝕚𝕟𝕘 ᚖ#5720 (ME) |
| German |  |
| Italian |  |
| Japanese |  |
| Portuguese| Dartzinho_V#8820 |
| Russian | spoon#0407 |
| Spanish |  |
| Traditional Chinese | zxcPandora#1581 |

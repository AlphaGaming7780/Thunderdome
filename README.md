
# Titanfall Legends

Titanfall Legends is a mod for Northstar (Titanfall 2), this mod adds a new game mode: Battle Royale.

Players will join a lobby and once the minimum required number of players has been reached, a vote for the map (of the Battle Royale) will take place. Once this vote has ended, the Battle Royale game will begin. The lobby is a classic FFA mod.

#### **This mod is required on both the client and server sides.**


## Documentation
It is possible to customize the game mode, by executing a command when starting the server, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlistvars)

Please don't use PlaylistOverrides that aren't in listed [here](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/README.md#playlistvars)

But if you want you can also edit [PlayLits_v2.txt](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/keyvalues/playlists_v2.txt) file, this file contains all PlayLists Var that can be edited, only edit var mentioned [here](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/README.md#playlistvars).

#### Exemple:

```
+setplaylistvaroverrides "max_players 10 max_teams 10 TBR_NumChest 40 TBR_SpawnWithMainWeapon 1 TBR_SpawnMainWeapon mp_weapon_car"
```

#### PlaylistVars

If the vars start with `BR_`, It mean that variable are only used for the Battle Royale game mode,
If the vars start with `LBR_`, It mean that variable are only used for the Lobby Battle Royale game mode,
And if they start with nothin before, It mean that variable are used for both game mode.

| PlaylistVars | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server, **need to be the same value for both game mode.** |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`, you can have 20 team max, game limite, so 20 player max, **need to be the same value for both game mode.**|
| `min_players` | `Int` | `2` | In Lobby game mode is the minimum player needed to start a game, in Batlle Royale game mode the min player needed to stop the game and return the player to the lobby. |
| `WaitingVoteTime` | `Float` | `30` | The time the server wait for player to vote for the next map, before it load the map the player vote. |
| `BR_canSpawnTitan` | `Int` | `0` | Allowed player to summon their titan, `0` : False, `1` : True |
| `BR_canUseBoost` | `Int` | `0` | Allowed player to use their boost, `0` : False, `1` : True |
| `BR_IntroLength` | `Int` | `10` | Time of the prematch state in seconde |
| `BR_NumChest` | `Int` | `20` | The numbres of chest that spawn in the map |
| `BR_SpawnWithMainWeapon` | `Int` | `0` | If the player spawn with a main weapon, `0` : False, `1` : True |
| `BR_SpawnWithSecondaryWeapon` | `Int` | `1` | If the player spawn with a secondary weapon, `0` : False, `1` : True |
| `BR_SpawnWithAntiTitanWeapon` | `Int` | `0` | If the player spawn with a anti titan weapon, `0` : False, `1` : True |
| `BR_SpawnMainWeapon` | `String` | `empty` | The main weapon the player will spawn with, `empty` = random weapon |
| `BR_SpawnSecondaryWeapon` | `String` | `mp_weapon_semipistol` | The secondary weapon the player will spawn whit, `empty` = random weapon |
| `BR_SpawnAntiTitanWeapon` | `String` | `empty` | The anti titan weapon the player will spawn whit, `empty` = random weapon |

## Special Thanks

### For answering my questions on [Discord](https://discord.gg/northstar)

    - Spoon#1812
    - uniboi#5786
    - Neinguar / NoCatt (NoCatt#8128)
    - [UK]The peepeepoopoo man (The peepeepoopoo man#3301)
    - BobTheBob#1150

### For translations
| Languag | Contributor |
| ------- | ----------- |
| English |  |
| French | ᚖ 𝔸𝕝𝕡𝕙𝕒 𝔾𝕒𝕞𝕚𝕟𝕘 ᚖ#5720 (ME) |
| German |  |
| Italian |  |
| Japanese |  |
| Portuguese|  |
| Russian | spoon#0407 |
| Spanish |  |
| Traditional Chinese |  |


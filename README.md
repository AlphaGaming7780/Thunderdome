
# Titanfall Legends

Titanfall Legends is a mod for Northstar (Titanfall 2), this mod add a new game mode: Battle Royale.

Players will join a lobby and once the minimum required number of players has been reached, a vote for the map (of the Battle Royale) will take place. Once this vote has ended, the Battle Royale game will begin. The lobby is a classic FFA mod.

The mod has great [customization](https://github.com/AlphaGaming7780/Thunderdome#documentation) possibilities by modifying the [ConVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#documentation) and the [PlaylitsVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides) of the game mode, for example, you can disable chest spawn, enable random weapon donation at spawn and end up with a FFADM (Free For All Death Match).

### **This mod is required on both the client and server sides.**


## Documentation
It is possible to customize the game mode with the [ConVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#convars) and [PlaylitsVars](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides) of the mod, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server)

If the vars start with `BR_`, it mean that variable are only used for all Battle Royale game mode except the Lobby,

If the vars start with `BR_SOLO_`, it mean that variable are only used for solo Battle Royale game mode,

if the vars start with `BR_SQUAD`, it mean that variable are only used for the squad Battle Royale game mode (Duo/Trio/Squad) (Not implemented yet)

if the vars start with `BR_LOBBY_`, it mean that variable are only used for the Lobby Battle Royale game mode,

and if they start with nothing before, it mean that variable are used for both game mode.

### ConVars
| ConVars | Accepted Values | Default Value | Description |
| ----------------- | --------------- | ------------- | ----------- |
| `TBR_min_players` | `Int` | `2` | In Lobby game mode is the minimum player needed to start a game, in Batlle Royale game mode the min player needed to stop the game and return the player to the lobby. |
|`TBR_EnableDevMod` | `Bool (Int)` | `0` | Enable the DEV mode |

### PlayListsvar
| `BR_canSpawnTitan` | `Bool (Int)` | `0` | Allowed player to summon their titan, `0` : False, `1` : True |
| `BR_canUseBoost` | `Bool (Int)` | `0` | Allowed player to use their boost, `0` : False, `1` : True |
| `BR_IntroLength` | `Int` | `10` | Time of the prematch state in seconde |
| `BR_MinNumChest` | `Int` | `20` | The numbres of chest that spawn in the map |
| `BR_SpawnWithMainWeapon` | `Bool  (Int)` | `0` | If the player spawn with a main weapon, `0` : False, `1` : True |
| `BR_SpawnWithSecondaryWeapon` | `Bool  (Int)` | `1` | If the player spawn with a secondary weapon, `0` : False, `1` : True |
| `BR_SpawnWithAntiTitanWeapon` | `Bool  (Int)` | `0` | If the player spawn with a anti titan weapon, `0` : False, `1` : True |
| `BR_SpawnMainWeapon` | `String` | `empty string ("")` | The main weapon the player will spawn with, `empty string ("")` = random weapon |
| `BR_SpawnSecondaryWeapon` | `String` | `mp_weapon_semipistol` | The secondary weapon the player will spawn whit, `empty string ("")` = random weapon |
| `BR_SpawnAntiTitanWeapon` | `String` | `empty string ("")` | The anti titan weapon the player will spawn whit, `empty string ("")` = random weapon |
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


# Titanfall Legends

A Titanfall Northstar mod, that add a battle royal game mode to the game


## Documentation
It is possible to customize the game mode, by executing a command when starting the server, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlistvars)

Please don't use PlaylistOverrides that aren't in listed [here](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/README.md#playlistvars)

But if you want you can also edit [PlayLits_v2.txt](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/keyvalues/playlists_v2.txt) file, this file contains all PlayLists Var that can be edited, only edit var mentioned [here](https://github.com/AlphaGaming7780/Titanfall_Legends/blob/main/README.md#playlistvars).

#### Exemple:

```
+setplaylistvaroverrides "max_players 10 max_teams 10 TBR_NumChest 40 TBR_SpawnWithMainWeapon 1 TBR_SpawnMainWeapon mp_weapon_car"
```

#### PlaylistVars
| PlaylistVars | Accepted Values | Default Value | Description |
| :---------------- | :-------------- | :------------ | :---------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`, you can have 20 team max, game limite, so 20 player max.|
| `min_players` | `Int` | `2` | The minimum player needed to start a game in the lobby, or the min player needed to stop the game and return the player to the lobby. |
| `WaitingVoteTime` | `Float` | `30` | The time the server wait for player to vote in the lobby, before it load the map the player vote. |
| `TBR_canSpawnTitan` | `Int` | `0` | Allowed player to summon their titan, `0` : False, `1` : True |
| `TBR_canUseBoost` | `Int` | `0` | Allowed player to use their boost, `0` : False, `1` : True |
| `TBR_IntroLength` | `Int` | `10` | Time the of the prematch state in seconde |
| `TBR_NumChest` | `Int` | `20` | The numbres of chest that spawn in the map |
| `TBR_SpawnWithMainWeapon` | `Int` | `0` | If the player spawn with a main weapon, `0` : False, `1` : True |
| `TBR_SpawnWithSecondaryWeapon` | `Int` | `1` | If the player spawn with a secondary weapon, `0` : False, `1` : True |
| `TBR_SpawnWithAntiTitanWeapon` | `Int` | `0` | If the player spawn with a anti titan weapon, `0` : False, `1` : True |
| `TBR_SpawnMainWeapon` | `String` | `empty` | The main weapon the player will spawn with, `empty` = random weapon |
| `TBR_SpawnSecondaryWeapon` | `String` | `mp_weapon_autopistol` | The secondary weapon the player will spawn whit, `empty` = random weapon |
| `TBR_SpawnAntiTitanWeapon` | `String` | `empty` | The anti titan weapon the player will spawn whit, `empty` = random weapon |

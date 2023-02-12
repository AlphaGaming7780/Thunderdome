
# Titanfall Legends

A Titanfall Northstar mod, that add a battle royal game mode to the game


## Documentation

It is possible to customize the game mode, by executing a command when starting the server, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides)

Please don't use PlaylistOverrides that aren't in listed [here](https://github.com/AlphaGaming7780/Titanfall-Legends/blob/main/README.md#playlistoverrides)

#### Exemple:

```
  +setplaylistvaroverrides "max_players 10 max_teams 10 TBR_NumChest 40 TBR_SpawnWithMainWeapon 1 TBR_SpawnMainWeapon mp_weapon_car"
```

#### PlaylistOverrides

| PlaylistOverrides | Accepted Values | Default Value | Description |
| :---------------- | :-------------- | :------------ | :---------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`|
| `min_players` | `Int` | `2` | The min player needed to start the game (try to don't change, don't know what would append) |
| `waitingPlayerTime` | `Int` | `30` | The time the server wait for player, befor the allow them to spawn |
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
